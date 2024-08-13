import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/application/presentation/navigator/complete_application_navigator.dart';
import 'package:final_assignment/features/application/presentation/navigator/hired_application_navigator.dart';
import 'package:final_assignment/features/auth/presentation/navigator/login_navigator.dart';
import 'package:final_assignment/features/home/presentation/view/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewNavigatorProvider = Provider<HomeViewNavigator>((ref) {
  return HomeViewNavigator();
});

class HomeViewNavigator
    with
        LoginViewRoute,
        CompleteApplicationViewRoute,
        HiredApplicationViewRoute {}

mixin HomeViewRoute {
  openHomeView() {
    NavigateRoute.pushRoute(const HomeView());
  }
}
