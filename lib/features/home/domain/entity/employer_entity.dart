import 'package:equatable/equatable.dart';

class EmployerEntity extends Equatable {
  final String id;
  final String organizationName;
  final String employerImage;

  const EmployerEntity({
    required this.id,
    required this.organizationName,
    required this.employerImage,
  });

  @override
  List<Object?> get props => [id, organizationName, employerImage];
}
