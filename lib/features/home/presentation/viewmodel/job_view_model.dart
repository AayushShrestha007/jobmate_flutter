import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:final_assignment/features/home/domain/usecases/job_usecase.dart';
import 'package:final_assignment/features/home/presentation/navigator/dashboard_navigator.dart';
import 'package:final_assignment/features/home/presentation/state/job_state.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobViewModelProvider = StateNotifierProvider<JobViewModel, JobState>(
  (ref) => JobViewModel(
    ref.read(jobUseCaseProvider),
    ref.read(jobViewNavigatorProvider),
  ),
);

class JobViewModel extends StateNotifier<JobState> {
  final JobUseCase jobUseCase;

  final JobViewNavigator jobViewNavigator;

  JobViewModel(this.jobUseCase, this.jobViewNavigator)
      : super(JobState.initial()) {
    getAllJobs();
  }

  Future<void> resetState() async {
    state = JobState.initial();
    await getAllJobs();
  }

  Future<void> getAllJobs({bool loadMore = false}) async {
    if (state.isLoading || state.hasReachedMax) return;

    state = state.copyWith(isLoading: true);

    final currentState = state;
    final page = loadMore ? currentState.page + 1 : 1;
    final jobs = currentState.jobs;

    var data = await jobUseCase.getAllJobs(page);

    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);

        //temporarily commented for testing
        showMySnackBar(
            message: failure.error,
            color: const Color.fromARGB(255, 154, 139, 0));
      },
      (newJobs) {
        state = state.copyWith(
          isLoading: false,
          jobs: loadMore ? [...jobs, ...newJobs] : newJobs,
          error: null,
          page: page,
          hasReachedMax: newJobs.isEmpty,
        );
      },
    );
  }

  Future<void> applyToJob(String jobId, String resumeId) async {
    state = state.copyWith(isLoading: true);

    final result = await jobUseCase.applyToJob(jobId, resumeId);

    result.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(
            message: failure.error,
            color: const Color.fromARGB(255, 154, 139, 0));
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        showMySnackBar(message: "Applied to job successfully");

        //remove the applied job from the list
        final updatedJobs = state.jobs.where((job) => job.id != jobId).toList();
        state = state.copyWith(jobs: updatedJobs);
      },
    );
  }

  void openJobDetailView(JobEntity job) {
    jobViewNavigator.openJobDetailView(job: job);
  }
}
