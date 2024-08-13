import 'package:final_assignment/features/application/presentation/viewmodel/application_view_model.dart';
import 'package:final_assignment/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const MyAppBar({required this.title, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);

    return AppBar(
      title: Text(title),
      actions: [
        if (authState.isLoading)
          const CircularProgressIndicator()
        else if (authState.imageName != null)
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Hired Jobs') {
                // Navigate to Hired Jobs screen
                Navigator.pushNamed(context, '/hiredJobs');
              } else if (value == 'Complete Jobs') {
                // Navigate to Complete Jobs screen
                Navigator.pushNamed(context, '/completeJobs');
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Hired Jobs', 'Complete Jobs'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            child: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'
                  // 'http://localhost:5500/userImage/${authState.imageName}',
                  ),
              radius: 18,
            ),
          )
        else
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Hired Jobs') {
                ref
                    .read(applicationViewModelProvider.notifier)
                    .openHiredApplicationView();
              } else if (value == 'Complete Jobs') {
                ref
                    .read(applicationViewModelProvider.notifier)
                    .openCompletedApplicationView();
              }
            },
            itemBuilder: (BuildContext context) {
              return {'Hired Jobs', 'Complete Jobs'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            icon: const Icon(Icons.account_circle, size: 36),
          ),
        const SizedBox(width: 16),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
