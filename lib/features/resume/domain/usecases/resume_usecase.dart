import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:final_assignment/features/resume/domain/repository/resume_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resumeUseCaseProvider = Provider((ref) {
  return ResumeUseCase(ref.read(resumeRepositoryProvider));
});

class ResumeUseCase {
  final IResumeRepository _resumeRepository;

  ResumeUseCase(this._resumeRepository);

  Future<Either<Failure, ResumeEntity>> createResume(
      ResumeEntity resume, String pdfPath) async {
    return await _resumeRepository.createResume(resume, pdfPath);
  }

  Future<Either<Failure, List<ResumeEntity>>> getAllResumes() async {
    return await _resumeRepository.getAllResumes();
  }
}
