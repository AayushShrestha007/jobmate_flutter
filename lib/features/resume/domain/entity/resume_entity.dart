import 'package:equatable/equatable.dart';

class ResumeEntity extends Equatable {
  final String? id;
  final String applicantId;
  final String resumeTitle;
  final String previousCompanyName;
  final String jobTitle;
  final String jobDuration;
  final String jobDescription;
  final String highestEducation;
  final String educationInstitute;
  final String? fileUrl;

  const ResumeEntity({
    this.id,
    required this.resumeTitle,
    required this.applicantId,
    required this.previousCompanyName,
    required this.jobTitle,
    required this.jobDuration,
    required this.jobDescription,
    required this.highestEducation,
    required this.educationInstitute,
    this.fileUrl,
  });

  @override
  List<Object?> get props => [
        id,
        applicantId,
        resumeTitle,
        previousCompanyName,
        jobTitle,
        jobDuration,
        jobDescription,
        highestEducation,
        educationInstitute,
        fileUrl,
      ];
}
