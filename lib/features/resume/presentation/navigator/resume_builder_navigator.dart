import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/resume/presentation/navigator/resume_list_navigator.dart';
import 'package:final_assignment/features/resume/presentation/view/resume_builder_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resumeBuilderViewNavigatorProvider =
    Provider<ResumeBuilderViewNavigator>((ref) {
  return ResumeBuilderViewNavigator();
});

class ResumeBuilderViewNavigator with ResumeListViewRoute {}

mixin ResumeBuilderViewRoute {
  openResumeBuilderView() {
    NavigateRoute.pushRoute(const ResumeBuilderView());
  }
}
