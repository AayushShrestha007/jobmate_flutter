import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authUseCaseProvider = Provider((ref) {
  return AuthUseCase(ref.read(authRepositoryProvider));
});

class AuthUseCase {
  final IAuthRepository _authRepository;

  AuthUseCase(this._authRepository);

  Future<Either<Failure, bool>> registerApplicant(AuthEntity? applicant) async {
    return await _authRepository
        .registerApplicant(applicant ?? AuthEntity.empty());
  }

  Future<Either<Failure, bool>> loginApplicant(
      String? email, String? password) async {
    return await _authRepository.loginApplicant(email ?? "", password ?? "");
  }

  Future<Either<Failure, AuthEntity>> getCurrentApplicant() async {
    return await _authRepository.getCurrentApplicant();
  }
}
