import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthController extends Notifier<AuthState> {
  AuthController({required Provider<LoginUseCase> loginUseCaseProvider})
    : _loginUseCaseProvider = loginUseCaseProvider;

  final Provider<LoginUseCase> _loginUseCaseProvider;

  @override
  AuthState build() => const AuthInitial();

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final result = await ref.read(_loginUseCaseProvider)(
      LoginUsecaseParams(email: email, password: password),
    );

    state = result.fold<AuthState>(
      (failure) => AuthFailure(
        message: failure is AppAuthFailure
            ? failure.message
            : failure.toString(),
      ),
      (user) => AuthSuccess(email: user.email),
    );
  }
}
