import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:final_assignment/features/home/domain/repository/job_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobUseCaseProvider = Provider((ref) {
  return JobUseCase(ref.read(jobRepositoryProvider));
});

class JobUseCase {
  final IJobRepository _jobRepository;

  JobUseCase(this._jobRepository);

  Future<Either<Failure, List<JobEntity>>> getAllJobs(int page) async {
    return await _jobRepository.getAllJobs(page);
  }

  Future<Either<Failure, bool>> applyToJob(
      String jobId, String resumeId) async {
    return await _jobRepository.applyToJob(jobId, resumeId);
  }
}
