import '../../data/models/auth_user_model.dart';

class AuthUserEntity {
  const AuthUserEntity({required this.email, required this.password});

  final String email;
  final String password;

  factory AuthUserEntity.fromModel(AuthUserModel model) {
    return AuthUserEntity(email: model.email, password: model.password);
  }

  AuthUserModel toModel() {
    return AuthUserModel(email: email, password: password);
  }
}
