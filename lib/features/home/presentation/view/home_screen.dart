import 'package:final_assignment/features/application/presentation/view/applications_view.dart';
import 'package:final_assignment/features/application/presentation/view/offered_applications_view.dart.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/jobs_view.dart';
import 'package:final_assignment/features/resume/presentation/view/resume_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = [
    const JobsView(),
    const ResumeListView(),
    const ApplicationsView(),
    const OfferedJobsView()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Resume',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Applied',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer),
            label: 'Offer',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
