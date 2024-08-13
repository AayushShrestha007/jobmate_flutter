import 'package:final_assignment/features/home/domain/entity/employer_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employer_api_model.g.dart';

@JsonSerializable()
class EmployerApiModel {
  @JsonKey(name: '_id')
  final String id;
  final String organizationName;
  final String employerImage;

  EmployerApiModel({
    required this.id,
    required this.organizationName,
    required this.employerImage,
  });

  factory EmployerApiModel.fromJson(Map<String, dynamic> json) =>
      _$EmployerApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployerApiModelToJson(this);

  // Convert API Object to Entity
  EmployerEntity toEntity() => EmployerEntity(
        id: id,
        organizationName: organizationName,
        employerImage: employerImage,
      );

  // Convert Entity to API Object
  static EmployerApiModel fromEntity(EmployerEntity entity) {
    return EmployerApiModel(
      id: entity.id,
      organizationName: entity.organizationName,
      employerImage: entity.employerImage,
    );
  }

  // Convert API List to Entity List
  static List<EmployerEntity> toEntityList(List<EmployerApiModel> models) {
    return models.map((model) => model.toEntity()).toList();
  }

  // Convert Entity List to API List
  static List<EmployerApiModel> fromEntityList(List<EmployerEntity> entities) {
    return entities.map((entity) => fromEntity(entity)).toList();
  }
}
