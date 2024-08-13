import 'package:final_assignment/features/application/domain/entity/application_entity.dart';
import 'package:final_assignment/features/home/data/model/job_api_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'application_api_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ApplicationApiModel {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'applicant')
  final String applicantId;
  @JsonKey(name: 'job')
  final JobApiModel job;
  final String status;
  @JsonKey(name: 'appliedOn', fromJson: _fromJson, toJson: _toJson)
  final DateTime appliedOn;
  @JsonKey(name: 'resume')
  final String? resumeId;

  ApplicationApiModel({
    required this.id,
    required this.applicantId,
    required this.job,
    required this.status,
    required this.appliedOn,
    this.resumeId,
  });

  factory ApplicationApiModel.fromJson(Map<String, dynamic> json) =>
      _$ApplicationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ApplicationApiModelToJson(this);

  // Convert API Object to Entity
  ApplicationEntity toEntity() {
    return ApplicationEntity(
      id: id,
      applicantId: applicantId,
      job: job.toEntity(),
      status: status,
      appliedOn: appliedOn,
      resumeId: resumeId,
    );
  }

  // Convert Entity to API Object
  static ApplicationApiModel fromEntity(ApplicationEntity entity) {
    return ApplicationApiModel(
      id: entity.id,
      applicantId: entity.applicantId,
      job: JobApiModel.fromEntity(entity.job),
      status: entity.status,
      appliedOn: entity.appliedOn,
      resumeId: entity.resumeId,
    );
  }

  // Convert API List to Entity List
  static List<ApplicationEntity> toEntityList(
      List<ApplicationApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // Helper methods to convert JSON date strings to DateTime and vice versa
  static DateTime _fromJson(String date) => DateTime.parse(date);
  static String _toJson(DateTime date) => date.toIso8601String();
}
