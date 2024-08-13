// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplicationApiModel _$ApplicationApiModelFromJson(Map<String, dynamic> json) =>
    ApplicationApiModel(
      id: json['_id'] as String,
      applicantId: json['applicant'] as String,
      job: JobApiModel.fromJson(json['job'] as Map<String, dynamic>),
      status: json['status'] as String,
      appliedOn: ApplicationApiModel._fromJson(json['appliedOn'] as String),
      resumeId: json['resume'] as String?,
    );

Map<String, dynamic> _$ApplicationApiModelToJson(
        ApplicationApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'applicant': instance.applicantId,
      'job': instance.job.toJson(),
      'status': instance.status,
      'appliedOn': ApplicationApiModel._toJson(instance.appliedOn),
      'resume': instance.resumeId,
    };
