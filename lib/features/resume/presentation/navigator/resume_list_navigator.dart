import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/resume/presentation/navigator/resume_builder_navigator.dart';
import 'package:final_assignment/features/resume/presentation/view/resume_list_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final resumeListViewNavigatorProvider =
    Provider<ResumeListViewNavigator>((ref) {
  return ResumeListViewNavigator();
});

class ResumeListViewNavigator with ResumeBuilderViewRoute {}

mixin ResumeListViewRoute {
  openResumeListView() {
    NavigateRoute.pushRoute(const ResumeListView());
  }
}
