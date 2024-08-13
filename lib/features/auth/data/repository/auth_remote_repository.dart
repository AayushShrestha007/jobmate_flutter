import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authRemoteRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthRemoteRepository(
    ref.read(authRemoteDataSourceProvider),
  );
});

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRemoteRepository(this._authRemoteDataSource);

 
  @override
  Future<Either<Failure, bool>> loginApplicant(String email, String password) {
    return _authRemoteDataSource.loginApplicant(email, password);
  }

  @override
  Future<Either<Failure, bool>> registerApplicant(AuthEntity applicant) {
    return _authRemoteDataSource.registerApplicant(applicant);
  }

  @override
  Future<Either<Failure, AuthEntity>> getCurrentApplicant() {
    return _authRemoteDataSource.getCurrentApplicant();
  }
}
