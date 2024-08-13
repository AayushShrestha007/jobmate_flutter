import 'package:final_assignment/core/common/my_appbar.dart';
import 'package:final_assignment/features/application/presentation/viewmodel/application_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HiredApplicationsView extends ConsumerStatefulWidget {
  const HiredApplicationsView({super.key});

  @override
  ConsumerState<HiredApplicationsView> createState() =>
      _HiredApplicationsViewState();
}

class _HiredApplicationsViewState extends ConsumerState<HiredApplicationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Fetch the hired jobs when the view is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(applicationViewModelProvider.notifier).getHiredApplications();
    });

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels != 0) {
        ref
            .read(applicationViewModelProvider.notifier)
            .getHiredApplications(loadMore: true);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final applicationState = ref.watch(applicationViewModelProvider);

    return NotificationListener<ScrollEndNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter == 0) {
          ref
              .read(applicationViewModelProvider.notifier)
              .getHiredApplications(loadMore: true);
        }
        return true;
      },
      child: Scaffold(
        appBar: const MyAppBar(
          title: "Hired Jobs",
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            ref
                .read(applicationViewModelProvider.notifier)
                .resetHiredApplicationsState();
          },
          child: Column(
            children: [
              if (applicationState.isLoading &&
                  applicationState.hiredApplications.isEmpty)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (applicationState.error != null)
                Expanded(
                  child: Center(
                    child: Text(
                      'Error: ${applicationState.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (applicationState.hiredApplications.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text('No hired jobs found',
                        style: TextStyle(fontSize: 18)),
                  ),
                )
              else
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: applicationState.hiredApplications.length +
                        (applicationState.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == applicationState.hiredApplications.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final application =
                          applicationState.hiredApplications[index];
                      final job = application.job;

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
                                    'http://localhost:5500/employerImage/${job.employer.employerImage}',
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
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        job.employer.organizationName,
                                        style: const TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(job.description),
                            const SizedBox(height: 8),
                            Text('Status: ${application.status}'),
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
