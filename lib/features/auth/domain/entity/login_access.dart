import '../../../staff/domain/entity/staff_entity.dart';
import 'user_authorization_entity.dart';

sealed class LoginAccess {
  const LoginAccess();
}

final class LoginAllowed extends LoginAccess {
  const LoginAllowed({required this.staff, required this.authorization});

  final StaffEntity staff;
  final UserAuthorizationEntity authorization;
}

final class RegistrationRequired extends LoginAccess {
  const RegistrationRequired({
    required this.staff,
    required this.authorization,
  });

  final StaffEntity staff;
  final UserAuthorizationEntity authorization;
}

final class LoginDenied extends LoginAccess {
  const LoginDenied({required this.message});

  final String message;
}

/// Returned when the identifier is not present in the staff table.
///
/// Supabase-only admins can still be valid if their user id is linked in
/// `user_authorization`, but that can only be verified after sign-in.
final class StaffNotFound extends LoginAccess {
  const StaffNotFound();
}
