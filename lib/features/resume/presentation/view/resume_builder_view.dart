import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:final_assignment/features/resume/presentation/viewmodel/resume_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResumeBuilderView extends ConsumerStatefulWidget {
  const ResumeBuilderView({super.key});

  @override
  ConsumerState<ResumeBuilderView> createState() => _ResumeBuilderViewState();
}

class _ResumeBuilderViewState extends ConsumerState<ResumeBuilderView> {
  final _formKey = GlobalKey<FormState>();

  final _resumeTitleController =
      TextEditingController(text: "Senior Flutter Dev");
  final _previousCompanyNameController =
      TextEditingController(text: "Digi Tech");
  final _jobTitleController =
      TextEditingController(text: "Senior Flutter Developer");
  final _jobDurationController = TextEditingController(text: "3 Years");
  final _jobDescriptionController = TextEditingController(
      text: "Supervise junior devs and write code in clean code architecture");
  final _highestQualificationController =
      TextEditingController(text: "Masters");
  final _educationInstituteController =
      TextEditingController(text: "Softwarica");

  @override
  void dispose() {
    _resumeTitleController.dispose();
    _previousCompanyNameController.dispose();
    _jobTitleController.dispose();
    _jobDurationController.dispose();
    _jobDescriptionController.dispose();
    _highestQualificationController.dispose();
    _educationInstituteController.dispose();
    super.dispose();
  }

  void _buildResume() async {
    if (_formKey.currentState?.validate() ?? false) {
      final resume = ResumeEntity(
        id: '', // id will be set by the backend
        applicantId: '', // applicantId will be set by the backend
        resumeTitle: _resumeTitleController.text,
        previousCompanyName: _previousCompanyNameController.text,
        jobTitle: _jobTitleController.text,
        jobDuration: _jobDurationController.text,
        jobDescription: _jobDescriptionController.text,
        highestEducation: _highestQualificationController.text,
        educationInstitute: _educationInstituteController.text,
        fileUrl: '',
      );

      ref.read(resumeViewModelProvider.notifier).createResume(resume);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resumeState = ref.watch(resumeViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Build Your Resume'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _resumeTitleController,
                  decoration: const InputDecoration(labelText: 'Resume Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a resume title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _previousCompanyNameController,
                  decoration:
                      const InputDecoration(labelText: 'Previous Company Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the previous company name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _jobTitleController,
                  decoration: const InputDecoration(labelText: 'Job Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the job title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _jobDurationController,
                  decoration: const InputDecoration(labelText: 'Job Duration'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the job duration';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _jobDescriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Job Description',
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the job description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _highestQualificationController,
                  decoration:
                      const InputDecoration(labelText: 'Highest Qualification'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the highest qualification';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _educationInstituteController,
                  decoration:
                      const InputDecoration(labelText: 'Education Institute'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the education institute';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _buildResume,
                    child: const Text('Create Resume'),
                  ),
                ),
                const SizedBox(height: 16),
                if (resumeState.isLoading) const CircularProgressIndicator(),
                if (resumeState.error != null)
                  Text(resumeState.error!,
                      style: const TextStyle(color: Colors.red)),
                if (resumeState.pdfPath != null)
                  SizedBox(
                    height: 600,
                    child: PDFView(
                      filePath: resumeState.pdfPath!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
