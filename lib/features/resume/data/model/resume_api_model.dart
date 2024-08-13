import 'package:final_assignment/features/resume/domain/entity/resume_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'resume_api_model.g.dart';

@JsonSerializable()
class ResumeApiModel {
  @JsonKey(name: '_id') // Assuming '_id' is used in the JSON
  final String? id;
  @JsonKey(name: 'applicant')
  final String applicantId;
  final String resumeTitle;
  final String previousCompanyName;
  final String jobTitle;
  final String jobDuration;
  final String jobDescription;
  final String highestEducation;
  final String educationInstitute;
  final String? fileUrl;

  ResumeApiModel({
    this.id,
    required this.applicantId,
    required this.resumeTitle,
    required this.previousCompanyName,
    required this.jobTitle,
    required this.jobDuration,
    required this.jobDescription,
    required this.highestEducation,
    required this.educationInstitute,
    this.fileUrl,
  });

  factory ResumeApiModel.fromJson(Map<String, dynamic> json) =>
      _$ResumeApiModelFromJson(json);
  Map<String, dynamic> toJson() => _$ResumeApiModelToJson(this);

// Convert API object to entity
  ResumeEntity toEntity() {
    return ResumeEntity(
      id: id,
      applicantId: applicantId,
      resumeTitle: resumeTitle,
      previousCompanyName: previousCompanyName,
      jobTitle: jobTitle,
      jobDuration: jobDuration,
      jobDescription: jobDescription,
      highestEducation: highestEducation,
      educationInstitute: educationInstitute,
      fileUrl: fileUrl,
    );
  }

  // Convert Entity to API Object
  static ResumeApiModel fromEntity(ResumeEntity entity) {
    return ResumeApiModel(
      id: entity.id,
      resumeTitle: entity.resumeTitle,
      applicantId: entity.applicantId,
      previousCompanyName: entity.previousCompanyName,
      jobTitle: entity.jobTitle,
      jobDuration: entity.jobDuration,
      jobDescription: entity.jobDescription,
      highestEducation: entity.highestEducation,
      educationInstitute: entity.educationInstitute,
      fileUrl: entity.fileUrl,
    );
  }

  // Convert API List to Entity List
  static List<ResumeEntity> toEntityList(List<ResumeApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }
}
