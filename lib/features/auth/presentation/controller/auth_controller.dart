import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entity/auth_user_entity.dart';
import '../../domain/entity/login_access.dart';
import '../../domain/usecases/check_login_access_usecase.dart';
import '../../domain/usecases/get_user_authorization_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_user_usecase.dart';
import 'auth_state.dart';

class AuthController extends Notifier<AuthState> {
  AuthController({
    required Provider<LoginUseCase> loginUseCaseProvider,
    required Provider<CheckLoginAccessUseCase> checkLoginAccessUseCaseProvider,
    required Provider<GetUserAuthorizationUseCase>
    getUserAuthorizationUseCaseProvider,
    required Provider<RegisterUserUseCase> registerUserUseCaseProvider,
  }) : _loginUseCaseProvider = loginUseCaseProvider,
       _checkLoginAccessUseCaseProvider = checkLoginAccessUseCaseProvider,
       _getUserAuthorizationUseCaseProvider =
           getUserAuthorizationUseCaseProvider,
       _registerUserUseCaseProvider = registerUserUseCaseProvider;

  final Provider<LoginUseCase> _loginUseCaseProvider;
  final Provider<CheckLoginAccessUseCase> _checkLoginAccessUseCaseProvider;
  final Provider<GetUserAuthorizationUseCase>
  _getUserAuthorizationUseCaseProvider;
  final Provider<RegisterUserUseCase> _registerUserUseCaseProvider;

  RegistrationRequired? _pendingRegistration;

  @override
  AuthState build() => const AuthInitial();

  Future<void> login({required String email, required String password}) async {
    state = const AuthLoading();

    final accessResult = await ref.read(_checkLoginAccessUseCaseProvider)(
      email,
    );

    final accessFailure = accessResult.fold<AppFailure?>(
      (failure) => failure,
      (_) => null,
    );
    if (accessFailure != null) {
      state = AuthFailure(message: _messageFor(accessFailure));
      return;
    }

    final access = accessResult.fold<LoginAccess?>(
      (_) => null,
      (value) => value,
    );

    switch (access) {
      case null:
        return;
      case StaffNotFound():
        await _signInWithoutStaff(identifier: email, password: password);
        return;
      case LoginDenied(:final message):
        state = AuthFailure(message: message);
        return;
      case RegistrationRequired():
        _pendingRegistration = null;
        state = const AuthFailure(
          message:
              'This admin account has not been activated yet. Use "Register new admin" to set a password.',
        );
        return;
      case LoginAllowed(:final staff):
        _pendingRegistration = null;
        await _signIn(email: staff.email, password: password);
    }
  }

  void startRegistration() {
    _pendingRegistration = null;
    state = const AuthRegistrationStarted();
  }

  Future<void> checkRegistrationEmail(String email) async {
    state = const AuthRegistrationStarted(isCheckingEmail: true);

    final result = await ref.read(_checkLoginAccessUseCaseProvider)(email);

    result.fold(
      (failure) {
        state = AuthRegistrationStarted(errorMessage: _messageFor(failure));
      },
      (access) {
        switch (access) {
          case final RegistrationRequired registration:
            _pendingRegistration = registration;
            state = AuthRegistrationRequired(email: registration.staff.email);
          case LoginAllowed():
            state = const AuthRegistrationStarted(
              errorMessage:
                  'This admin account is already activated. Please sign in.',
            );
          case StaffNotFound():
            state = const AuthRegistrationStarted(
              errorMessage: 'No admin account found for this email.',
            );
          case LoginDenied(:final message):
            state = AuthRegistrationStarted(errorMessage: message);
        }
      },
    );
  }

  Future<void> register({required String password}) async {
    final pending = _pendingRegistration;
    if (pending == null) {
      state = const AuthFailure(
        message: 'Your registration session expired. Please sign in again.',
      );
      return;
    }

    state = AuthRegistrationRequired(
      email: pending.staff.email,
      isSubmitting: true,
    );

    final result = await ref.read(_registerUserUseCaseProvider)(
      RegisterUserParams(
        email: pending.staff.email,
        password: password,
        staff: pending.staff,
        authorization: pending.authorization,
      ),
    );

    result.fold(
      (failure) {
        state = AuthRegistrationRequired(
          email: pending.staff.email,
          errorMessage: _messageFor(failure),
        );
      },
      (user) {
        _pendingRegistration = null;
        state = AuthSuccess(email: user.email);
      },
    );
  }

  void cancelRegistration() {
    _pendingRegistration = null;
    state = const AuthInitial();
  }

  Future<void> _signInWithoutStaff({
    required String identifier,
    required String password,
  }) async {
    final loginResult = await ref.read(_loginUseCaseProvider)(
      LoginUsecaseParams(email: identifier, password: password),
    );

    final loginFailure = loginResult.fold<AppFailure?>(
      (failure) => failure,
      (_) => null,
    );
    if (loginFailure != null) {
      state = AuthFailure(message: _messageFor(loginFailure));
      return;
    }

    final user = loginResult.fold<AuthUserEntity?>(
      (_) => null,
      (value) => value,
    );
    final userId = user?.id;
    if (userId == null || user == null) {
      state = const AuthFailure(
        message: 'Unable to identify the signed-in account.',
      );
      return;
    }

    final authorizationResult = await ref.read(
      _getUserAuthorizationUseCaseProvider,
    )(userId);

    authorizationResult.fold(
      (failure) => state = AuthFailure(message: _messageFor(failure)),
      (authorization) {
        if (authorization == null || !authorization.canAccessAdminPanel) {
          state = AuthFailure(message: notAuthorizedLoginMessage);
          return;
        }

        state = AuthSuccess(email: user.email);
      },
    );
  }

  Future<void> _signIn({
    required String email,
    required String password,
  }) async {
    final result = await ref.read(_loginUseCaseProvider)(
      LoginUsecaseParams(email: email, password: password),
    );

    state = result.fold<AuthState>(
      (failure) => AuthFailure(message: _messageFor(failure)),
      (_) => AuthSuccess(email: email),
    );
  }

  String _messageFor(AppFailure failure) =>
      failure is AppAuthFailure ? failure.message : failure.toString();
}
