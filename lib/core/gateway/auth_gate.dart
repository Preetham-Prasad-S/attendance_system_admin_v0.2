import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/controller/admin_session_state.dart';
import '../../features/auth/presentation/controller/auth_state.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_user_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../shared/screens/base_screen.dart';
import '../dependency_injection.dart';
import 'admin_session_provider.dart';

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authStateChangesProvider);
    final adminSession = ref.watch(adminSessionProvider);
    final authState = ref.watch(authControllerProvider);

    return session.when(
      loading: () => const SplashScreen(),
      error: (error, _) => LoginScreen(errorMessage: error.toString()),
      data: (sessionState) {
        if (sessionState.session == null) {
          final registrationEmail = switch (authState) {
            AuthRegistrationStarted() => '',
            AuthRegistrationRequired(:final email) => email,
            _ => null,
          };
          if (registrationEmail != null) {
            return RegisterUserScreen(email: registrationEmail);
          }

          final message = switch (adminSession) {
            AdminSessionDenied(:final message) => message,
            AdminSessionSignedOut(:final message) => message,
            _ => null,
          };

          return LoginScreen(errorMessage: message);
        }

        return switch (adminSession) {
          AdminSessionChecking() => const SplashScreen(),
          AdminSessionAuthorized() => const BaseScreen(),
          AdminSessionDenied(:final message) => LoginScreen(
            errorMessage: message,
          ),
          AdminSessionSignedOut() => const SplashScreen(),
        };
      },
    );
  }
}
