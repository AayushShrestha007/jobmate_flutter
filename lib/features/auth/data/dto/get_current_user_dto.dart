import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_current_user_dto.g.dart';

@JsonSerializable()
class GetCurrentApplicantDto {
  @JsonKey(name: "_id")
  final String id;
  final String name;
  final String phone;
  final String email;

  GetCurrentApplicantDto({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  AuthEntity toEntity() {
    return AuthEntity(
        id: id, name: name, email: email, phone: phone, password: '');
  }

  factory GetCurrentApplicantDto.fromJson(Map<String, dynamic> json) =>
      _$GetCurrentApplicantDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrentApplicantDtoToJson(this);
}
