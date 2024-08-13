import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/resume/data/data_source/remote/resume_remote_data_source.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:final_assignment/features/resume/domain/repository/resume_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resumeRemoteRepositoryProvider = Provider<IResumeRepository>((ref) {
  return ResumeRemoteRepository(
    ref.read(resumeRemoteDataSourceProvider),
  );
});

class ResumeRemoteRepository implements IResumeRepository {
  final ResumeRemoteDataSource _resumeRemoteDataSource;
  ResumeRemoteRepository(this._resumeRemoteDataSource);

  @override
  Future<Either<Failure, ResumeEntity>> createResume(
      ResumeEntity resume, String pdfPath) {
    return _resumeRemoteDataSource.createResume(resume, pdfPath);
  }

   Future<Either<Failure, List<ResumeEntity>>> getAllResumes() {
    return _resumeRemoteDataSource.getAllResumes();
  }

}
