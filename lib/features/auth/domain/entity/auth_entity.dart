import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/application/domain/entity/application_entity.dart';
import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';

class AuthEntity extends Equatable {
  final String? id;
  final String name;
  final String phone;
  final String? userImage;
  final String email;
  final String password;
  final List<ResumeEntity>? resumes;
  final List<ApplicationEntity>? applications;

  const AuthEntity({
    this.id,
    required this.name,
    required this.phone,
    this.userImage,
    required this.email,
    required this.password,
    this.resumes,
    this.applications,
  });

  AuthEntity.empty()
      : this(
          name: "",
          phone: "",
          email: "",
          password: "",
          userImage: "",
          resumes: [],
          applications: [],
        );

  @override
  List<Object?> get props =>
      [id, name, phone, userImage, email, password, resumes, applications];
}
