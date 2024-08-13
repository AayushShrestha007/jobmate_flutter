import 'package:equatable/equatable.dart';
import 'package:final_assignment/features/application/domain/entity/application_entity.dart';

class ApplicationState extends Equatable {
  final bool isLoading;
  final bool isLoadingMore;
  final List<ApplicationEntity> appliedApplications;
  final List<ApplicationEntity> jobOfferedApplications;
  final List<ApplicationEntity> hiredApplications;
  final List<ApplicationEntity> completeApplications;
  final String? error;
  final bool hasReachedMaxApplied;
  final bool hasReachedMaxOffered;
  final bool hasReachedMaxHired;
  final bool hasReachedMaxComplete;
  final int appliedPage;
  final int offeredPage;
  final int hiredPage;
  final int completePage;

  const ApplicationState({
    required this.isLoading,
    required this.isLoadingMore,
    required this.appliedApplications,
    required this.jobOfferedApplications,
    required this.hiredApplications,
    required this.completeApplications,
    this.error,
    required this.hasReachedMaxApplied,
    required this.hasReachedMaxOffered,
    required this.hasReachedMaxHired,
    required this.hasReachedMaxComplete,
    required this.appliedPage,
    required this.offeredPage,
    required this.hiredPage,
    required this.completePage,
  });

  factory ApplicationState.initial() {
    return const ApplicationState(
      isLoading: false,
      isLoadingMore: false,
      appliedApplications: [],
      jobOfferedApplications: [],
      hiredApplications: [],
      completeApplications: [],
      error: null,
      hasReachedMaxApplied: false,
      hasReachedMaxOffered: false,
      hasReachedMaxHired: false,
      hasReachedMaxComplete: false,
      appliedPage: 1,
      offeredPage: 1,
      hiredPage: 1,
      completePage: 1,
    );
  }

  ApplicationState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    List<ApplicationEntity>? appliedApplications,
    List<ApplicationEntity>? jobOfferedApplications,
    List<ApplicationEntity>? hiredApplications,
    List<ApplicationEntity>? completeApplications,
    String? error,
    bool? hasReachedMaxApplied,
    bool? hasReachedMaxOffered,
    bool? hasReachedMaxHired,
    bool? hasReachedMaxComplete,
    int? appliedPage,
    int? offeredPage,
    int? hiredPage,
    int? completePage,
  }) {
    return ApplicationState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      appliedApplications: appliedApplications ?? this.appliedApplications,
      jobOfferedApplications:
          jobOfferedApplications ?? this.jobOfferedApplications,
      hiredApplications: hiredApplications ?? this.hiredApplications,
      completeApplications: completeApplications ?? this.completeApplications,
      error: error ?? this.error,
      hasReachedMaxApplied: hasReachedMaxApplied ?? this.hasReachedMaxApplied,
      hasReachedMaxOffered: hasReachedMaxOffered ?? this.hasReachedMaxOffered,
      hasReachedMaxHired: hasReachedMaxHired ?? this.hasReachedMaxHired,
      hasReachedMaxComplete:
          hasReachedMaxComplete ?? this.hasReachedMaxComplete,
      appliedPage: appliedPage ?? this.appliedPage,
      offeredPage: offeredPage ?? this.offeredPage,
      hiredPage: hiredPage ?? this.hiredPage,
      completePage: completePage ?? this.completePage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isLoadingMore,
        appliedApplications,
        jobOfferedApplications,
        hiredApplications,
        completeApplications,
        error,
        hasReachedMaxApplied,
        hasReachedMaxOffered,
        hasReachedMaxHired,
        hasReachedMaxComplete,
        appliedPage,
        offeredPage,
        hiredPage,
        completePage,
      ];

  @override
  String toString() =>
      'ApplicationState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, appliedApplications: $appliedApplications, jobOfferedApplications: $jobOfferedApplications, hiredApplications: $hiredApplications, completeApplications: $completeApplications, error: $error, hasReachedMaxApplied: $hasReachedMaxApplied, hasReachedMaxOffered: $hasReachedMaxOffered, hasReachedMaxHired: $hasReachedMaxHired, hasReachedMaxComplete: $hasReachedMaxComplete, appliedPage: $appliedPage, offeredPage: $offeredPage, hiredPage: $hiredPage, completePage: $completePage)';
}
