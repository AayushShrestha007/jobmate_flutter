import 'package:final_assignment/app/themes/app_theme.dart';
import 'package:final_assignment/app/themes/theme_notifier.dart';
import 'package:final_assignment/features/payment/presentation/view/khalti_payment_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(themeNotifierProvider);
    return KhaltiScope(
        publicKey: 'test_public_key_d5d9f63743584d38753056b0cc737d5',
        enabledDebugging: true,
        builder: (context, navKey) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // navigatorKey: AppNavigator.navigatorKey,
            navigatorKey: navKey,
            // home: const SplashView(),
            home: const KhaltiPaymentView(),
            localizationsDelegates: const [KhaltiLocalizations.delegate],
            theme: AppTheme.getApplicationTheme(isDarkTheme),
          );
        });
  }
}
