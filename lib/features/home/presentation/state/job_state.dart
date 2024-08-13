import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';

class JobState extends Equatable {
  final bool isLoading;
  final List<JobEntity> jobs;
  final String? error;
  final bool hasReachedMax;
  final int page;

  const JobState({
    required this.isLoading,
    required this.jobs,
    this.error,
    required this.hasReachedMax,
    required this.page,
  });

  factory JobState.initial() {
    return const JobState(
      isLoading: false,
      jobs: [],
      error: null,
      hasReachedMax: false,
      page: 0,
    );
  }

  JobState copyWith({
    bool? isLoading,
    List<JobEntity>? jobs,
    String? error,
    bool? hasReachedMax,
    int? page,
  }) {
    return JobState(
      isLoading: isLoading ?? this.isLoading,
      jobs: jobs ?? this.jobs,
      error: error ?? this.error,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
    );
  }

  @override
  List<Object?> get props => [isLoading, jobs, error, hasReachedMax, page];

  @override
  String toString() =>
      'JobState(isLoading: $isLoading, jobs: $jobs, error: $error, hasReachedMax: $hasReachedMax, page: $page)';
}
