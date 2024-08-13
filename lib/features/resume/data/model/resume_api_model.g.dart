// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResumeApiModel _$ResumeApiModelFromJson(Map<String, dynamic> json) =>
    ResumeApiModel(
      id: json['_id'] as String?,
      applicantId: json['applicant'] as String,
      resumeTitle: json['resumeTitle'] as String,
      previousCompanyName: json['previousCompanyName'] as String,
      jobTitle: json['jobTitle'] as String,
      jobDuration: json['jobDuration'] as String,
      jobDescription: json['jobDescription'] as String,
      highestEducation: json['highestEducation'] as String,
      educationInstitute: json['educationInstitute'] as String,
      fileUrl: json['fileUrl'] as String?,
    );

Map<String, dynamic> _$ResumeApiModelToJson(ResumeApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'applicant': instance.applicantId,
      'resumeTitle': instance.resumeTitle,
      'previousCompanyName': instance.previousCompanyName,
      'jobTitle': instance.jobTitle,
      'jobDuration': instance.jobDuration,
      'jobDescription': instance.jobDescription,
      'highestEducation': instance.highestEducation,
      'educationInstitute': instance.educationInstitute,
      'fileUrl': instance.fileUrl,
    };
