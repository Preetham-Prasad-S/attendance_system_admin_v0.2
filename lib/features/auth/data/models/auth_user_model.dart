class AuthUserModel {
  const AuthUserModel({required this.email, required this.password, this.id});

  final String email;
  final String password;
  final String? id;
}
