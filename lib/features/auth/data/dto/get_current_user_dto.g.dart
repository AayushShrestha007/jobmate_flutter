// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrentApplicantDto _$GetCurrentApplicantDtoFromJson(
        Map<String, dynamic> json) =>
    GetCurrentApplicantDto(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$GetCurrentApplicantDtoToJson(
        GetCurrentApplicantDto instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
    };
