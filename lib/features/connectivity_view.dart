import 'package:final_assignment/core/common/provider/internet_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConnectivityView extends StatelessWidget {
  const ConnectivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer(
          builder: (context, ref, child) {
            final connectivitStatus = ref.watch(connectivityStatusProvider);
            if (connectivitStatus == ConnectivityStatus.isConnected) {
              return const Text("Internet is connected");
            }
            return const Text("Internet isn't connected");
          },
        ),
      ),
    );
  }
}
