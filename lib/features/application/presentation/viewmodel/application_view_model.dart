import 'package:final_assignment/features/application/domain/usecases/application_usecase.dart';
import 'package:final_assignment/features/application/presentation/state/application_state.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final applicationViewModelProvider =
    StateNotifierProvider<ApplicationViewModel, ApplicationState>(
  (ref) => ApplicationViewModel(ref.read(applicationUseCaseProvider),
      ref.read(homeViewNavigatorProvider)),
);

class ApplicationViewModel extends StateNotifier<ApplicationState> {
  ApplicationViewModel(this._applicationUseCase, this.homeViewNavigator)
      : super(ApplicationState.initial()) {
    getAppliedApplications();
    getJobOfferedApplications();
  }

  final ApplicationUseCase _applicationUseCase;
  final HomeViewNavigator homeViewNavigator;

  Future<void> resetAppliedApplicationsState() async {
    state = state.copyWith(
      appliedApplications: [],
      appliedPage: 1,
      hasReachedMaxApplied: false,
      error: null,
      isLoading: false,
      isLoadingMore: false,
    );
    await getAppliedApplications();
  }

  Future<void> resetJobOfferedApplicationsState() async {
    state = state.copyWith(
      jobOfferedApplications: [],
      offeredPage: 1,
      hasReachedMaxOffered: false,
      error: null,
      isLoading: false,
      isLoadingMore: false,
    );
    await getJobOfferedApplications();
  }

  Future<void> resetHiredApplicationsState() async {
    state = state.copyWith(
      hiredApplications: [],
      hiredPage: 1,
      hasReachedMaxHired: false,
      error: null,
      isLoading: false,
      isLoadingMore: false,
    );
    await getHiredApplications();
  }

  Future<void> resetCompleteApplicationsState() async {
    state = state.copyWith(
      completeApplications: [],
      completePage: 1,
      hasReachedMaxComplete: false,
      error: null,
      isLoading: false,
      isLoadingMore: false,
    );
    await getCompleteApplications();
  }

  Future<void> getAppliedApplications({bool loadMore = false}) async {
    if ((state.isLoading || state.hasReachedMaxApplied) && !loadMore) return;

    state = state.copyWith(isLoading: !loadMore, isLoadingMore: loadMore);

    final currentState = state;
    final page = loadMore ? currentState.appliedPage + 1 : 1;
    final applications = currentState.appliedApplications;

    var data = await _applicationUseCase.getAppliedApplications(page);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: failure.error,
        );
      },
      (newApplications) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          appliedApplications: loadMore
              ? [...applications, ...newApplications]
              : newApplications,
          error: null,
          appliedPage: page,
          hasReachedMaxApplied: newApplications.isEmpty,
        );
      },
    );
  }

  Future<void> getJobOfferedApplications({bool loadMore = false}) async {
    if ((state.isLoading || state.hasReachedMaxOffered) && !loadMore) return;

    state = state.copyWith(isLoading: !loadMore, isLoadingMore: loadMore);

    final currentState = state;
    final page = loadMore ? currentState.offeredPage + 1 : 1;
    final applications = currentState.jobOfferedApplications;

    var data = await _applicationUseCase.getJobOfferedApplications(page);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: failure.error,
        );
      },
      (newApplications) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          jobOfferedApplications: loadMore
              ? [...applications, ...newApplications]
              : newApplications,
          error: null,
          offeredPage: page,
          hasReachedMaxOffered: newApplications.isEmpty,
        );
      },
    );
  }

  Future<void> getHiredApplications({bool loadMore = false}) async {
    if ((state.isLoading || state.hasReachedMaxHired) && !loadMore) return;

    state = state.copyWith(isLoading: !loadMore, isLoadingMore: loadMore);

    final currentState = state;
    final page = loadMore ? currentState.hiredPage + 1 : 1;
    final applications = currentState.hiredApplications;

    var data = await _applicationUseCase.getJobHiredApplications(page);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: failure.error,
        );
      },
      (newApplications) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          hiredApplications: loadMore
              ? [...applications, ...newApplications]
              : newApplications,
          error: null,
          hiredPage: page,
          hasReachedMaxHired: newApplications.isEmpty,
        );
      },
    );
  }

  Future<void> getCompleteApplications({bool loadMore = false}) async {
    if ((state.isLoading || state.hasReachedMaxComplete) && !loadMore) return;

    state = state.copyWith(isLoading: !loadMore, isLoadingMore: loadMore);

    final currentState = state;
    final page = loadMore ? currentState.completePage + 1 : 1;
    final applications = currentState.completeApplications;

    var data = await _applicationUseCase.getJobCompleteApplications(page);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          error: failure.error,
        );
      },
      (newApplications) {
        state = state.copyWith(
          isLoading: false,
          isLoadingMore: false,
          completeApplications: loadMore
              ? [...applications, ...newApplications]
              : newApplications,
          error: null,
          completePage: page,
          hasReachedMaxComplete: newApplications.isEmpty,
        );
      },
    );
  }

  Future<void> acceptJobOffer(String applicationId) async {
    state = state.copyWith(isLoading: true);

    var data = await _applicationUseCase.acceptJobOffer(applicationId);

    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
      },
      (message) {
        state = state.copyWith(
          isLoading: false,
          error: null,
        );

        resetJobOfferedApplicationsState();
      },
    );
  }

  void openCompletedApplicationView() {
    homeViewNavigator.openCompleteApplicationView();
  }

  void openHiredApplicationView() {
    homeViewNavigator.openHiredApplicationView();
  }
}
