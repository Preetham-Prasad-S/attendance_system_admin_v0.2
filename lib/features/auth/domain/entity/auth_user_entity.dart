import '../../data/models/auth_user_model.dart';

class AuthUserEntity {
  const AuthUserEntity({required this.email, required this.password, this.id});

  final String email;
  final String password;
  final String? id;

  factory AuthUserEntity.fromModel(AuthUserModel model) {
    return AuthUserEntity(
      email: model.email,
      password: model.password,
      id: model.id,
    );
  }

  AuthUserModel toModel() {
    return AuthUserModel(email: email, password: password, id: id);
  }
}
