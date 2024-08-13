import 'package:final_assignment/core/common/my_snackbar.dart';
import 'package:final_assignment/features/auth/domain/entity/auth_entity.dart';
import 'package:final_assignment/features/auth/domain/usecases/auth_usecase.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/register_navigator.dart';
import 'package:final_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:final_assignment/features/home/presentation/navigator/home_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = StateNotifierProvider<AuthViewModel, AuthState>(
  (ref) => AuthViewModel(
      ref.read(loginViewNavigatorProvider),
      ref.read(registerViewNavigatorProvider),
      ref.read(authUseCaseProvider),
      ref.read(homeViewNavigatorProvider)),
);

class AuthViewModel extends StateNotifier<AuthState> {
  AuthViewModel(this.loginViewNavigator, this.registerViewNavigator,
      this.authUseCase, this.homeViewNavigator)
      : super(AuthState.initial()) {
    // getCurrentApplicant();
  }

  final AuthUseCase authUseCase;
  final LoginViewNavigator loginViewNavigator;
  final RegisterViewNavigator registerViewNavigator;
  final HomeViewNavigator homeViewNavigator;

  Future<void> registerApplicant(AuthEntity applicant) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.registerApplicant(applicant);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );

        //temporarily commented for testing
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(
          isLoading: false,
          error: null,
          imageName: applicant.userImage,
        );
        //temporarily commented for testing
        showMySnackBar(message: "Successfully registered");
      },
    );
  }

  Future<void> loginApplicant(
    String email,
    String password,
  ) async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.loginApplicant(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);

        //temporarily commented for testing
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        openHomeView();
      },
    );
  }

  Future<void> getCurrentApplicant() async {
    state = state.copyWith(isLoading: true);
    var data = await authUseCase.getCurrentApplicant();
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showMySnackBar(message: failure.error, color: Colors.red);
      },
      (applicant) {
        state = state.copyWith(
            isLoading: false, error: null, imageName: applicant.userImage);
      },
    );
  }

  void openRegisterView() {
    loginViewNavigator.openRegisterView();
  }

  void openLoginView() {
    registerViewNavigator.openLoginView();
  }

  void openHomeView() {
    loginViewNavigator.openHomeView();
  }
}
