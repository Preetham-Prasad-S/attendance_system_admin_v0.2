sealed class AuthState {
  const AuthState();

  bool get isLoading => false;
}

final class AuthInitial extends AuthState {
  const AuthInitial();
}

final class AuthLoading extends AuthState {
  const AuthLoading();

  @override
  bool get isLoading => true;
}

final class AuthSuccess extends AuthState {
  const AuthSuccess({required this.email});

  final String email;

  AuthSuccess copyWith({String? email}) {
    return AuthSuccess(email: email ?? this.email);
  }
}

final class AuthFailure extends AuthState {
  const AuthFailure({required this.message});

  final String message;
}
