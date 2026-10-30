import '../models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthUserModel> login(AuthUserModel user);

  Future<AuthUserModel> signup(AuthUserModel user);
}
