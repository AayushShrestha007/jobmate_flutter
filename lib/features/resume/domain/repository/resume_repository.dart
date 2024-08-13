import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/resume/data/repository/resume_remote_repository.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resumeRepositoryProvider = Provider<IResumeRepository>((ref) {
  return ref.read(resumeRemoteRepositoryProvider);
});

abstract class IResumeRepository {
  Future<Either<Failure, ResumeEntity>> createResume(
      ResumeEntity resume, String pdfPath);
  Future<Either<Failure, List<ResumeEntity>>> getAllResumes();
}
