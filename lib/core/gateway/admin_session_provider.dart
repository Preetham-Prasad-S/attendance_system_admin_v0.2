import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/controller/admin_session_state.dart';
import '../dependency_injection.dart';
import '../usecase/no_params.dart';

const String adminAccessDeniedMessage =
    'Your account is not authorized to access the admin panel.';

final adminSessionProvider =
    NotifierProvider<AdminSessionController, AdminSessionState>(
      AdminSessionController.new,
    );

class AdminSessionController extends Notifier<AdminSessionState> {
  String? _authorizedUserId;
  String? _lastDenialMessage;
  int _verificationId = 0;
  bool _disposed = false;

  @override
  AdminSessionState build() {
    ref.onDispose(() => _disposed = true);

    ref.listen(authStateChangesProvider, (previous, next) {
      if (next.isLoading) return;

      final userId = next.valueOrNull?.session?.user.id;
      Future.microtask(() => _handleUserId(userId));
    }, fireImmediately: true);

    return const AdminSessionChecking();
  }

  Future<void> _handleUserId(String? userId) async {
    if (_disposed) return;

    if (userId == null) {
      state = AdminSessionSignedOut(message: _lastDenialMessage);
      return;
    }

    if (_authorizedUserId == userId && state is AdminSessionAuthorized) {
      return;
    }

    final verificationId = ++_verificationId;
    state = const AdminSessionChecking();

    final result = await ref.read(getUserAuthorizationUseCaseProvider)(userId);

    if (_disposed || verificationId != _verificationId) return;

    final authorization = result.fold((_) => null, (value) => value);

    if (authorization?.canAccessAdminPanel ?? false) {
      _authorizedUserId = userId;
      _lastDenialMessage = null;
      state = AdminSessionAuthorized(authorization: authorization!);
      return;
    }

    _authorizedUserId = null;
    _lastDenialMessage = adminAccessDeniedMessage;
    await ref.read(signOutUseCaseProvider)(const NoParams());

    if (_disposed) return;

    state = const AdminSessionDenied(message: adminAccessDeniedMessage);
  }
}
