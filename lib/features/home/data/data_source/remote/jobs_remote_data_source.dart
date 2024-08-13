import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/applicant_shared_prefs.dart';
import 'package:final_assignment/features/home/data/model/job_api_model.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobRemoteDataSourceProvider = Provider<JobRemoteDataSource>(
  (ref) => JobRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    sharedPrefs: ref.read(applicantSharedPrefsProvider),
  ),
);

class JobRemoteDataSource {
  final Dio dio;
  final ApplicantSharedPrefs sharedPrefs;

  JobRemoteDataSource({required this.dio, required this.sharedPrefs});

//code to get all jobs
  Future<Either<Failure, List<JobEntity>>> getAllJobs(int page) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult =
          await sharedPrefs.getApplicantToken();
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

      Response response = await dio.get(
        ApiEndpoints.getAllJobs,
        queryParameters: {
          'page': page,
          'limit': ApiEndpoints.limitPage,
        },
      );

      if (response.statusCode == 200) {
        if (response.data.containsKey('jobs')) {
          List<dynamic> jobList = response.data['jobs'];
          List<JobEntity> jobs = jobList
              .map((job) => JobApiModel.fromJson(job).toEntity())
              .toList();
          return Right(jobs);
        } else {
          return Left(Failure(
            error: "Response does not contain 'jobs' key",
            statusCode: response.statusCode.toString(),
          ));
        }
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

   Future<Either<Failure, bool>> applyToJob(String jobId, String resumeId) async {
    try {
      // Get the token from storage
      Either<Failure, String?> tokenResult = await sharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
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

      // Make the request to apply to the job
      Response response = await dio.post(
        ApiEndpoints.applyToJob,
        data: {
          'jobId': jobId,
          'resumeId': resumeId, // Include resumeId in the request data
        },
      );

      if (response.statusCode == 201) {
        return const Right(true);
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


