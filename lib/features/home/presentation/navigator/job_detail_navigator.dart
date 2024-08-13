import 'package:final_assignment/app/navigator/navigator.dart';
import 'package:final_assignment/features/home/domain/entity/job_entity.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/job_detail_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobDetailViewNavigatorProvider = Provider<JobDetailViewNavigator>((ref) {
  return JobDetailViewNavigator();
});

class JobDetailViewNavigator {}

mixin JobDetailViewRoute {
  openJobDetailView({required JobEntity job}) {
    NavigateRoute.pushRoute(JobDetailView(job: job));
  }
}
