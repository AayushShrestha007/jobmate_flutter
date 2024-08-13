import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/local/hive_service.dart';
import 'package:final_assignment/features/auth/data/model/auth_hive_model.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authLocalDataSourceProvider = Provider(
  (ref) => AuthLocalDataSource(
    ref.read(hiveServiceProvider),
    ref.read(authHiveModelProvider),
  ),
);

class AuthLocalDataSource {
  final HiveService _hiveService;
  final AuthHiveModel _authHiveModel;

  AuthLocalDataSource(this._hiveService, this._authHiveModel);

  Future<Either<Failure, bool>> registerApplicant(AuthEntity applicant) async {
    try {
      await _hiveService.addApplicant(_authHiveModel.toHiveModel(applicant));
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }

  Future<Either<Failure, bool>> loginApplicant(
    String email,
    String password,
  ) async {
    try {
      AuthHiveModel? applicants = await _hiveService.login(email, password);
      return const Right(true);
    } catch (e) {
      return Left(Failure(error: e.toString()));
    }
  }
}
