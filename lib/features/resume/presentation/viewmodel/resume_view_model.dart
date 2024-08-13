import 'dart:io';

import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:final_assignment/features/resume/domain/usecases/resume_usecase.dart';
import 'package:final_assignment/features/resume/presentation/navigator/resume_builder_navigator.dart';
import 'package:final_assignment/features/resume/presentation/navigator/resume_list_navigator.dart';
import 'package:final_assignment/features/resume/presentation/state/resume_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

final resumeViewModelProvider =
    StateNotifierProvider<ResumeViewModel, ResumeState>(
  (ref) => ResumeViewModel(
    ref.read(resumeUseCaseProvider),
    ref.read(resumeListViewNavigatorProvider),
    ref.read(resumeBuilderViewNavigatorProvider),
  ),
);

class ResumeViewModel extends StateNotifier<ResumeState> {
  ResumeViewModel(this.resumeUseCase, this.resumeListViewNavigator,
      this.resumeBuilderViewNavigator)
      : super(ResumeState.initial());

  final ResumeUseCase resumeUseCase;
  final ResumeListViewNavigator resumeListViewNavigator;
  final ResumeBuilderViewNavigator resumeBuilderViewNavigator;

  Future<void> createResume(ResumeEntity resume) async {
    // Generate the PDF file
    final pdfFile = await _generatePdf(resume);

    state = state.copyWith(isLoading: true);
    var data = await resumeUseCase.createResume(resume, pdfFile.path);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (newResume) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          resumes: [...state.resumes, newResume],
          pdfPath: pdfFile.path,
        );
        showMySnackBar(message: "Resume created successfully");
      },
    );
  }

  Future<File> _generatePdf(ResumeEntity resume) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Resume', style: const pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 16),
            pw.Text('Resume Title: ${resume.resumeTitle}'),
            pw.Text('Previous Company Name: ${resume.previousCompanyName}'),
            pw.Text('Job Title: ${resume.jobTitle}'),
            pw.Text('Job Duration: ${resume.jobDuration}'),
            pw.Text('Job Description: ${resume.jobDescription}'),
            pw.Text('Highest Qualification: ${resume.highestEducation}'),
            pw.Text('Education Institute: ${resume.educationInstitute}'),
          ],
        ),
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File(path.join(output.path, 'resume.pdf'));
    await file.writeAsBytes(await pdf.save());
    return file;
  }

  Future<void> getAllResumes() async {
    state = state.copyWith(isLoading: true);
    print("Fetching resumes..."); // Debug print
    var data = await resumeUseCase.getAllResumes();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        print("Error fetching resumes: ${failure.error}"); // Debug print
      },
      (resumes) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          resumes: resumes,
        );
        print("Fetched resumes: ${resumes.length}"); // Debug print
      },
    );
  }

  void openResumeBuilderView() {
    resumeListViewNavigator.openResumeBuilderView();
  }
}
