import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/dashboard/presentation/screens/base_screen.dart';
import '../dependency_injection.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authStateChangesProvider);

    return session.when(
      loading: () => const SplashScreen(),
      data: (authState) {
        if (authState.session != null) {
          return const BaseScreen();
        }

        return const LoginScreen();
      },
      error: (error, _) => LoginScreen(errorMessage: error.toString()),
    );
  }
}
