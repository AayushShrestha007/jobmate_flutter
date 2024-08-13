import 'package:final_assignment/features/home/presentation/navigator/job_detail_navigator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobViewNavigatorProvider = Provider<JobViewNavigator>((ref) {
  return JobViewNavigator();
});

class JobViewNavigator with JobDetailViewRoute {}
