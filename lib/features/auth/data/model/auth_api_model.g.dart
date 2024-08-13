// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthApiModel _$AuthApiModelFromJson(Map<String, dynamic> json) => AuthApiModel(
      name: json['name'] as String,
      id: json['_id'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String?,
      userImage: json['userImage'] as String?,
      resumes: (json['resumes'] as List<dynamic>?)
          ?.map((e) => ResumeApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      applications: (json['applications'] as List<dynamic>?)
          ?.map((e) => ApplicationApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthApiModelToJson(AuthApiModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'userImage': instance.userImage,
      'resumes': instance.resumes?.map((e) => e.toJson()).toList(),
      'applications': instance.applications?.map((e) => e.toJson()).toList(),
    };
