import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/auth_local_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthLocalRepository(
    ref.read(authLocalDataSourceProvider),
  );
});

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  @override
  Future<Either<Failure, bool>> loginApplicant(String email, String password) {
    return _authLocalDataSource.loginApplicant(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerApplicant(AuthEntity applicant) {
    return _authLocalDataSource.registerApplicant(applicant);
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentApplicant() {
    // TODO: implement getCurrentApplicant
    throw UnimplementedError();
  }
}
