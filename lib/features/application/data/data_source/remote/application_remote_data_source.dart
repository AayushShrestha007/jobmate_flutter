import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/applicant_shared_prefs.dart';
import 'package:final_assignment/features/application/data/model/application_api_model.dart';
import 'package:final_assignment/features/application/domain/entity/application_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationRemoteDataSourceProvider = Provider(
  (ref) => ApplicationRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    applicantSharedPrefs: ref.read(applicantSharedPrefsProvider),
  ),
);

class ApplicationRemoteDataSource {
  final Dio dio;
  final ApplicantSharedPrefs applicantSharedPrefs;

  ApplicationRemoteDataSource({
    required this.dio,
    required this.applicantSharedPrefs,
  });

  Future<Either<Failure, List<ApplicationEntity>>> getAppliedApplications({
    required int page,
    int limit = ApiEndpoints.limitPage,
  }) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult =
          await applicantSharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(
            tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
      }
      String? token = tokenResult.getOrElse(() => null);
      if (token == null) {
        return Left(Failure(
          error: "Authorization token not found",
          statusCode: '401',
        ));
      }

      // Set the headers
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Make the request to get the applied applications
      Response response = await dio.get(
        ApiEndpoints.getAppliedApplications,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        List<ApplicationEntity> applications =
            (response.data['applications'] as List)
                .map((json) => ApplicationApiModel.fromJson(json).toEntity())
                .toList();
        print("Applications received: $applications");
        return Right(applications);
      } else {
        return Left(Failure(
          error: response.data["message"] ?? "Unexpected error occurred",
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: '0',
      ));
    }
  }

  //code to get offered applications list
  Future<Either<Failure, List<ApplicationEntity>>> getJobOfferedApplications({
    required int page,
    int limit = ApiEndpoints.limitPage,
  }) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult =
          await applicantSharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(
            tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
      }
      String? token = tokenResult.getOrElse(() => null);
      if (token == null) {
        return Left(Failure(
          error: "Authorization token not found",
          statusCode: '401',
        ));
      }

      // Set the headers
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Make the request to get the job-offered applications
      Response response = await dio.get(
        ApiEndpoints.getJobOfferedApplications,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        List<ApplicationEntity> applications =
            (response.data['applications'] as List)
                .map((json) => ApplicationApiModel.fromJson(json).toEntity())
                .toList();
        print("Job-offered applications received: $applications");
        return Right(applications);
      } else {
        return Left(Failure(
          error: response.data["message"] ?? "Unexpected error occurred",
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: '0',
      ));
    }
  }

// Get completed applications
  Future<Either<Failure, List<ApplicationEntity>>> getJobCompleteApplications({
    required int page,
    int limit = ApiEndpoints.limitPage,
  }) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult =
          await applicantSharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(
            tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
      }
      String? token = tokenResult.getOrElse(() => null);
      if (token == null) {
        return Left(Failure(
          error: "Authorization token not found",
          statusCode: '401',
        ));
      }

      // Set the headers
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Make the request to get the job-complete applications
      Response response = await dio.get(
        ApiEndpoints.getJobCompleteApplications,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        List<ApplicationEntity> applications =
            (response.data['applications'] as List)
                .map((json) => ApplicationApiModel.fromJson(json).toEntity())
                .toList();
        print("Job-complete applications received: $applications");
        return Right(applications);
      } else {
        return Left(Failure(
          error: response.data["message"] ?? "Unexpected error occurred",
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: '0',
      ));
    }
  }

  // Get hired applications
  Future<Either<Failure, List<ApplicationEntity>>> getJobHiredApplications({
    required int page,
    int limit = ApiEndpoints.limitPage,
  }) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult =
          await applicantSharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(
            tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
      }
      String? token = tokenResult.getOrElse(() => null);
      if (token == null) {
        return Left(Failure(
          error: "Authorization token not found",
          statusCode: '401',
        ));
      }

      // Set the headers
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Make the request to get the job-hired applications
      Response response = await dio.get(
        ApiEndpoints.getJobHiredApplications,
        queryParameters: {
          'page': page,
          'limit': limit,
        },
      );

      if (response.statusCode == 200) {
        List<ApplicationEntity> applications =
            (response.data['applications'] as List)
                .map((json) => ApplicationApiModel.fromJson(json).toEntity())
                .toList();
        print("Job-hired applications received: $applications");
        return Right(applications);
      } else {
        return Left(Failure(
          error: response.data["message"] ?? "Unexpected error occurred",
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: '0',
      ));
    }
  }

//accept job offer
  Future<Either<Failure, String>> acceptJobOffer(String applicationId) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult =
          await applicantSharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(
            tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
      }
      String? token = tokenResult.getOrElse(() => null);
      if (token == null) {
        return Left(Failure(
          error: "Authorization token not found",
          statusCode: '401',
        ));
      }

      // Set the headers
      dio.options.headers['Authorization'] = 'Bearer $token';

      // Make the request to accept the job offer
      Response response = await dio.put(
        ApiEndpoints.acceptJobOffer,
        data: {'applicationId': applicationId, 'status': 'hired'},
      );

      if (response.statusCode == 200) {
        return Right(
            response.data['message'] ?? 'Job offer accepted successfully');
      } else {
        return Left(Failure(
          error: response.data["message"] ?? "Unexpected error occurred",
          statusCode: response.statusCode.toString(),
        ));
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    } catch (e) {
      return Left(Failure(
        error: e.toString(),
        statusCode: '0',
      ));
    }
  }
}
