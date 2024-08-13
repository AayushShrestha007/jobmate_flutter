import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/data_source/remote/jobs_remote_data_source.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:final_assignment/features/home/domain/repository/job_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobRemoteRepositoryProvider = Provider<IJobRepository>((ref) {
  return JobRemoteRepository(
    ref.read(jobRemoteDataSourceProvider),
  );
});

class JobRemoteRepository implements IJobRepository {
  final JobRemoteDataSource _jobRemoteDataSource;

  JobRemoteRepository(this._jobRemoteDataSource);

  @override
  Future<Either<Failure, List<JobEntity>>> getAllJobs(int page) {
    return _jobRemoteDataSource.getAllJobs(page);
  }

  @override
  Future<Either<Failure, bool>> applyToJob(String jobId, String resumeId) {
    return _jobRemoteDataSource.applyToJob(jobId, resumeId);
  }
}
