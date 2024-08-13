// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employer_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployerApiModel _$EmployerApiModelFromJson(Map<String, dynamic> json) =>
    EmployerApiModel(
      id: json['_id'] as String,
      organizationName: json['organizationName'] as String,
      employerImage: json['employerImage'] as String,
    );

Map<String, dynamic> _$EmployerApiModelToJson(EmployerApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'organizationName': instance.organizationName,
      'employerImage': instance.employerImage,
    };
