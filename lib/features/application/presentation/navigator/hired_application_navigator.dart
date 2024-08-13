import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/application/presentation/view/hired_applications_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final hiredApplicationViewNavigatorProvider =
    Provider<HiredApplicationNavigator>((ref) => HiredApplicationNavigator());

class HiredApplicationNavigator {}

mixin HiredApplicationViewRoute {
  openHiredApplicationView() {
    NavigateRoute.pushRoute(const HiredApplicationsView());
  }
}
