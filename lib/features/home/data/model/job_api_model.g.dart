// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobApiModel _$JobApiModelFromJson(Map<String, dynamic> json) => JobApiModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      workType: json['workType'] as String,
      description: json['description'] as String,
      skills: json['skills'] as String,
      qualification: json['qualification'] as String,
      status: json['status'] as String,
      employer:
          EmployerApiModel.fromJson(json['employer'] as Map<String, dynamic>),
      applications: (json['applications'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
    );

Map<String, dynamic> _$JobApiModelToJson(JobApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'workType': instance.workType,
      'description': instance.description,
      'skills': instance.skills,
      'qualification': instance.qualification,
      'status': instance.status,
      'employer': instance.employer,
      'applications': instance.applications,
    };
