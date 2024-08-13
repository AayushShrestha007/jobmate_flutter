import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/application/data/repository/application_remote_repository.dart';
import 'package:final_assignment/features/application/domain/entity/application_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationRepositoryProvider = Provider<IApplicationRepository>((ref) {
  return ref.read(applicationRemoteRepositoryProvider);
});

abstract class IApplicationRepository {
  Future<Either<Failure, List<ApplicationEntity>>> getAppliedApplications(
      int page);
  Future<Either<Failure, List<ApplicationEntity>>> getJobOfferedApplications(
      int page);
  Future<Either<Failure, List<ApplicationEntity>>> getJobCompleteApplications(
      int page);
  Future<Either<Failure, List<ApplicationEntity>>> getJobHiredApplications(
      int page);
  Future<Either<Failure, String>> acceptJobOffer(String applicationId);
}
