import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/applicant_shared_prefs.dart';
import 'package:final_assignment/features/auth/data/dto/get_current_user_dto.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final authRemoteDataSourceProvider = Provider(
  (ref) => AuthRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    applicantSharedPrefs: ref.read(applicantSharedPrefsProvider),
  ),
);

class AuthRemoteDataSource {
  final Dio dio;
  final ApplicantSharedPrefs applicantSharedPrefs;

  AuthRemoteDataSource({required this.dio, required this.applicantSharedPrefs});

//code for registration with image
  Future<Either<Failure, bool>> registerApplicant(AuthEntity applicant) async {
    try {
      FormData formData = FormData.fromMap({
        "name": applicant.name,
        "phone": applicant.phone,
        "email": applicant.email,
        "password": applicant.password,
        // Sending the file as MultipartFile
        "userImage": await MultipartFile.fromFile(
          applicant.userImage!,
          filename: path.basename(applicant.userImage!),
        ),
      });

      Response response = await dio.post(
        ApiEndpoints.register,
        data: formData,
      );

      if (response.statusCode == 201) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

//code for logging in
  Future<Either<Failure, bool>> loginApplicant(
    String email,
    String password,
  ) async {
    try {
      Response response = await dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      if (response.statusCode == 201) {
        String token = response.data["token"];
        // Save token to shared prefs
        await applicantSharedPrefs.setApplicantToken(token);
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, AuthEntity>> getCurrentApplicant() async {
    try {
      // Get the token from shared prefs
      String? token;
      var data = await applicantSharedPrefs.getApplicantToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.get(
        ApiEndpoints.currentApplicant,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      if (response.statusCode == 200) {
        GetCurrentApplicantDto getCurrentApplicantDto =
            GetCurrentApplicantDto.fromJson(response.data);

        return Right(getCurrentApplicantDto.toEntity());
      } else {
        return Left(
          Failure(
            error: response.data["message"],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }
}
