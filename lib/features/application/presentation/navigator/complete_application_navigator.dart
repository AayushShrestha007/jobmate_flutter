import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/application/presentation/view/completed_applications_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final completeApplicationViewNavigatorProvider =
    Provider<CompleteApplicationNavigator>(
        (ref) => CompleteApplicationNavigator());

class CompleteApplicationNavigator {}

mixin CompleteApplicationViewRoute {
  openCompleteApplicationView() {
    NavigateRoute.pushRoute(const CompletedApplicationsView());
  }
}
