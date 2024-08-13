import 'package:final_assignment/features/application/data/model/application_api_model.dart';
import 'package:final_assignment/features/resume/data/model/resume_api_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';


part 'auth_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? password;
  final String? userImage;
  final List<ResumeApiModel>? resumes;
  final List<ApplicationApiModel>? applications;

  AuthApiModel({
    required this.name,
    required this.id,
    required this.email,
    required this.phone,
    required this.password,
    this.userImage,
    this.resumes,
    this.applications,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // Convert API model to entity
  AuthEntity toEntity() {
    return AuthEntity(
      id: id,
      name: name,
      phone: phone,
      email: email,
      password: password ?? '',
      userImage: userImage,
      resumes: resumes?.map((resume) => resume.toEntity()).toList(),
      applications: applications?.map((app) => app.toEntity()).toList(),
    );
  }
}
