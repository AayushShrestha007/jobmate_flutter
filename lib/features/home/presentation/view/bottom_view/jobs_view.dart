import 'package:all_sensors2/all_sensors2.dart';
import 'package:final_assignment/app/themes/theme_notifier.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/job_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JobsView extends ConsumerStatefulWidget {
  const JobsView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _JobsViewState();
}

class _JobsViewState extends ConsumerState<JobsView> {
  final ScrollController _scrollController = ScrollController();
  final double _shakeThreshold = 12;
  AccelerometerEvent? _lastAccelerometerEvent;
  GyroscopeEvent? _lastGyroscopeEvent;
  static const double _tiltThreshold = 2.0;

  @override
  void initState() {
    super.initState();

    // Initialize accelerometer listener
    accelerometerEvents?.listen((AccelerometerEvent event) {
      _handleAccelerometerEvent(event);
    });

    // Initialize gyroscope listener
    gyroscopeEvents?.listen((GyroscopeEvent event) {
      // _handleGyroscopeEvent(event);
    });
  }

  void _handleAccelerometerEvent(AccelerometerEvent event) {
    if (_lastAccelerometerEvent != null) {
      double changeX = (event.x - _lastAccelerometerEvent!.x).abs();
      double changeY = (event.y - _lastAccelerometerEvent!.y).abs();
      double changeZ = (event.z - _lastAccelerometerEvent!.z).abs();

      if (changeX > _shakeThreshold ||
          changeY > _shakeThreshold ||
          changeZ > _shakeThreshold) {
        ref.read(jobViewModelProvider.notifier).resetState();
      }
    }

    _lastAccelerometerEvent = event;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jobState = ref.watch(jobViewModelProvider);
    final isDarkTheme = ref.watch(themeNotifierProvider);

    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0) {
          ref.read(jobViewModelProvider.notifier).getAllJobs(loadMore: true);
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jobs'),
          actions: [
            Switch(
              value: isDarkTheme,
              onChanged: (value) {
                ref.read(themeNotifierProvider.notifier).toggleTheme();
              },
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.read(jobViewModelProvider.notifier).resetState();
          },
          child: Column(
            children: [
              if (jobState.isLoading && jobState.jobs.isEmpty)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (jobState.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      'Error: ${jobState.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (jobState.jobs.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('No jobs available'),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        jobState.jobs.length + (jobState.isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == jobState.jobs.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final job = jobState.jobs[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'http://localhost:5500/employerImage/${job.employer.employerImage}', // Adjust this URL to match your backend's image serving path
                                  ),
                                  radius: 30,
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        job.title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        job.employer.organizationName,
                                        style: const TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(job.description)),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                ref
                                    .read(jobViewModelProvider.notifier)
                                    .openJobDetailView(job);
                              },
                              child: const Text('Learn More'),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(thickness: 1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
