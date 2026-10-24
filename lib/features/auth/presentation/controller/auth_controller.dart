import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_state.dart';

class AuthController extends Notifier<AuthState> {
  @override
  AuthState build() => const AuthLoading();
}
