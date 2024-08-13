import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/application/domain/entity/application_entity.dart';
import 'package:final_assignment/features/application/domain/repository/application_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationUseCaseProvider = Provider<ApplicationUseCase>((ref) {
  return ApplicationUseCase(ref.read(applicationRepositoryProvider));
});

class ApplicationUseCase {
  final IApplicationRepository _repository;
  ApplicationUseCase(this._repository);

  Future<Either<Failure, List<ApplicationEntity>>> getAppliedApplications(
      int page) async {
    return await _repository.getAppliedApplications(page);
  }

  Future<Either<Failure, List<ApplicationEntity>>> getJobOfferedApplications(
      int page) async {
    return await _repository.getJobOfferedApplications(page);
  }

  Future<Either<Failure, List<ApplicationEntity>>> getJobCompleteApplications(
      int page) async {
    return await _repository.getJobCompleteApplications(page);
  }

  Future<Either<Failure, List<ApplicationEntity>>> getJobHiredApplications(
      int page) async {
    return await _repository.getJobHiredApplications(page);
  }

  Future<Either<Failure, String>> acceptJobOffer(String applicationId) async {
    return await _repository.acceptJobOffer(applicationId);
  }
}
