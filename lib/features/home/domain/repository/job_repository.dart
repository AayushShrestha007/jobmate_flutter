import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/home/data/repository/job_remote_repository.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobRepositoryProvider = Provider<IJobRepository>((ref) {
  return ref.read(jobRemoteRepositoryProvider);
  // You can also add logic to check for an internet connection and switch between local and remote repositories.
});

abstract class IJobRepository {
  Future<Either<Failure, List<JobEntity>>> getAllJobs(int page);
  Future<Either<Failure, bool>> applyToJob(String jobId, String resumeId);
}
