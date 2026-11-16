import '../../domain/entity/user_authorization_entity.dart';

sealed class AdminSessionState {
  const AdminSessionState();
}

final class AdminSessionChecking extends AdminSessionState {
  const AdminSessionChecking();
}

final class AdminSessionAuthorized extends AdminSessionState {
  const AdminSessionAuthorized({required this.authorization});

  final UserAuthorizationEntity authorization;
}

final class AdminSessionDenied extends AdminSessionState {
  const AdminSessionDenied({required this.message});

  final String message;
}

final class AdminSessionSignedOut extends AdminSessionState {
  const AdminSessionSignedOut({this.message});

  final String? message;
}
