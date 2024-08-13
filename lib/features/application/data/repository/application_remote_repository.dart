import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/application/data/data_source/remote/application_remote_data_source.dart';
import 'package:final_assignment/features/application/domain/entity/application_entity.dart';
import 'package:final_assignment/features/application/domain/repository/application_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationRemoteRepositoryProvider =
    Provider<IApplicationRepository>((ref) {
  return ApplicationRemoteRepository(
    ref.read(applicationRemoteDataSourceProvider),
  );
});

class ApplicationRemoteRepository implements IApplicationRepository {
  final ApplicationRemoteDataSource _applicationRemoteDataSource;
  ApplicationRemoteRepository(this._applicationRemoteDataSource);

  @override
  Future<Either<Failure, List<ApplicationEntity>>> getAppliedApplications(
      int page) {
    return _applicationRemoteDataSource.getAppliedApplications(page: page);
  }

  @override
  Future<Either<Failure, List<ApplicationEntity>>> getJobOfferedApplications(
      int page) {
    return _applicationRemoteDataSource.getJobOfferedApplications(page: page);
  }

  @override
  Future<Either<Failure, List<ApplicationEntity>>> getJobCompleteApplications(
      int page) {
    return _applicationRemoteDataSource.getJobCompleteApplications(page: page);
  }

  @override
  Future<Either<Failure, List<ApplicationEntity>>> getJobHiredApplications(
      int page) {
    return _applicationRemoteDataSource.getJobHiredApplications(page: page);
  }

  @override
  Future<Either<Failure, String>> acceptJobOffer(String applicationId) {
    return _applicationRemoteDataSource.acceptJobOffer(applicationId);
  }
}
