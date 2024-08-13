import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:final_assignment/app/constants/api_endpoint.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:final_assignment/core/networking/remote/http_service.dart';
import 'package:final_assignment/core/shared_prefs/applicant_shared_prefs.dart';
import 'package:final_assignment/features/resume/data/model/resume_api_model.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final resumeRemoteDataSourceProvider = Provider(
  (ref) => ResumeRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    applicantSharedPrefs: ref.read(applicantSharedPrefsProvider),
  ),
);

class ResumeRemoteDataSource {
  final Dio dio;
  final ApplicantSharedPrefs applicantSharedPrefs;

  ResumeRemoteDataSource(
      {required this.dio, required this.applicantSharedPrefs});

  Future<Either<Failure, ResumeEntity>> createResume(
      ResumeEntity resume, String pdfPath) async {
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

      // Create form data for file upload
      FormData formData = FormData.fromMap({
        "resumeTitle": resume.resumeTitle,
        "previousCompanyName": resume.previousCompanyName,
        "jobTitle": resume.jobTitle,
        "jobDuration": resume.jobDuration,
        "jobDescription": resume.jobDescription,
        "highestEducation": resume.highestEducation,
        "educationInstitute": resume.educationInstitute,
        "file": await MultipartFile.fromFile(
          pdfPath,
          filename: path.basename(pdfPath),
        ),
      });

      // Make the API call
      Response response = await dio.post(
        ApiEndpoints.createResume,
        data: formData,
      );

      if (response.statusCode == 201) {
        ResumeEntity newResume =
            ResumeApiModel.fromJson(response.data['resume']).toEntity();
        return Right(newResume);
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

  Future<Either<Failure, List<ResumeEntity>>> getAllResumes() async {
    try {
      final tokenResult = await applicantSharedPrefs.getApplicantToken();
      if (tokenResult.isLeft()) {
        return Left(
            tokenResult.fold((l) => l, (r) => Failure(error: "Unknown error")));
      }
      final token = tokenResult.getOrElse(() => null);
      if (token == null) {
        return Left(
            Failure(error: "Authorization token not found", statusCode: '401'));
      }

      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.get(ApiEndpoints.gettAllResume);

      if (response.statusCode == 200) {
        final resumes = (response.data['resumes'] as List)
            .map((resume) => ResumeApiModel.fromJson(resume).toEntity())
            .toList();
        return Right(resumes);
      } else {
        return Left(Failure(
            error: response.data["message"] ?? "Unexpected error occurred",
            statusCode: response.statusCode.toString()));
      }
    } on DioException catch (e) {
      return Left(Failure(
          error: e.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0'));
    } catch (e) {
      return Left(Failure(error: e.toString(), statusCode: '0'));
    }
  }
}
