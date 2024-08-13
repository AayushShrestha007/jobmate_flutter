import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/home/domain/entity/employer_entity.dart';

class JobEntity extends Equatable {
  final String? id;
  final String title;
  final String workType;
  final String description;
  final String skills;
  final String qualification;
  final String status;
  final EmployerEntity employer; // Add employer object
  final List<String> applications;

  const JobEntity({
    this.id,
    required this.title,
    required this.workType,
    required this.description,
    required this.skills,
    required this.qualification,
    required this.status,
    required this.employer,
    required this.applications,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        workType,
        description,
        skills,
        qualification,
        status,
        employer,
        applications,
      ];
}
