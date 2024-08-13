class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  // static const String baseUrl = "http://10.0.2.2:3000/api/v1/";
  static const String baseUrl = "http://localhost:5500/api/";
  // static const String baseUrl = "http://192.168.1.70:5500/api/";

  // ====================== Auth Routes ======================
  static const String login = "user/login";
  static const String register = "user/register";
  // static const String imageUrl = "http://10.0.2.2:5500/uploads/";
  // static const String uploadImage = "auth/uploadImage";
  static const String currentApplicant = "user/get_current_applicant";

  // ====================== Jobs Routes ======================
  static const String getAllJobs = "job/get_all_open_jobs";

  static const String applyToJob = "applications/apply";

  // ====================== Resume Routes ======================
  static const String createResume = "resume/create_resume";

  static const String gettAllResume = "resume/get_all_resume";

// ====================== Applications Routes ======================
  static const String getAppliedApplications =
      "applications/get_all_applications";

  static const String getJobOfferedApplications =
      "applications/get_all_offered_applications";

  static const String getJobHiredApplications =
      "applications/get_hired_application";

  static const String getJobCompleteApplications =
      "applications/get_complete_applications";

  static const String acceptJobOffer = "applications/update_application_status";

  static const limitPage = 5;
}
