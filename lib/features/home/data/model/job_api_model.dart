import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'employer_api_model.dart';

part 'job_api_model.g.dart';

@JsonSerializable()
class JobApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String title;
  final String workType;
  final String description;
  final String skills;
  final String qualification;
  final String status;
  @JsonKey(name: 'employer')
  final EmployerApiModel
      employer; // EmployerApiModel to map nested employer object
  @JsonKey(defaultValue: [])
  final List<String> applications;

  JobApiModel({
    required this.id,
    required this.title,
    required this.workType,
    required this.description,
    required this.skills,
    required this.qualification,
    required this.status,
    required this.employer,
    required this.applications,
  });

  factory JobApiModel.fromJson(Map<String, dynamic> json) =>
      _$JobApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$JobApiModelToJson(this);

  // To Entity
  JobEntity toEntity() {
    return JobEntity(
      id: id,
      title: title,
      workType: workType,
      description: description,
      skills: skills,
      qualification: qualification,
      status: status,
      employer: employer
          .toEntity(), // Convert nested EmployerApiModel to EmployerEntity
      applications: applications,
    );
  }

  // Convert Entity to API Object
  static JobApiModel fromEntity(JobEntity entity) {
    return JobApiModel(
      id: entity.id ?? '',
      title: entity.title,
      workType: entity.workType,
      description: entity.description,
      skills: entity.skills,
      qualification: entity.qualification,
      status: entity.status,
      employer: EmployerApiModel.fromEntity(
          entity.employer), // Convert EmployerEntity to EmployerApiModel
      applications: entity.applications,
    );
  }

  // Convert API List to Entity List
  static List<JobEntity> toEntityList(List<JobApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // Convert Entity List to API List
  static List<JobApiModel> fromEntityList(List<JobEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }
}
