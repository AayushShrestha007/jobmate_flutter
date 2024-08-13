import 'package:dartz/dartz.dart';
import 'package:final_assignment/core/failure/failure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final applicantSharedPrefsProvider = Provider<ApplicantSharedPrefs>((ref) {
  return ApplicantSharedPrefs();
});

class ApplicantSharedPrefs {
  late SharedPreferences _sharedPreferences;

  // Set applicant token
  Future<Either<Failure, bool>> setApplicantToken(String token) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.setString('applicant_token', token);
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get applicant token
  Future<Either<Failure, String?>> getApplicantToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      final token = _sharedPreferences.getString('applicant_token');
      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Set applicant data
  Future<Either<Failure, bool>> setApplicantData(
      Map<String, String> applicantData) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      applicantData.forEach((key, value) async {
        await _sharedPreferences.setString(key, value);
      });
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Get applicant data
  Future<Either<Failure, Map<String, String>>> getApplicantData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      Map<String, String> applicantData = {};
      Set<String> keys = _sharedPreferences.getKeys();
      for (String key in keys) {
        applicantData[key] = _sharedPreferences.getString(key) ?? "";
      }
      return right(applicantData);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete applicant token
  Future<Either<Failure, bool>> deleteApplicantToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('applicant_token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete all applicant data
  Future<Either<Failure, bool>> deleteAllApplicantData() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.clear();
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
