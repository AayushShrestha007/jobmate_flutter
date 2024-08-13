import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';

class ApplicationEntity extends Equatable {
  final String id;
  final String applicantId;
  final JobEntity job;
  final String status;
  final DateTime appliedOn;
  final String? resumeId;

  const ApplicationEntity({
    required this.id,
    required this.applicantId,
    required this.job,
    required this.status,
    required this.appliedOn,
    this.resumeId,
  });

  @override
  List<Object?> get props => [
        id,
        applicantId,
        job,
        status,
        appliedOn,
        resumeId,
      ];
}
