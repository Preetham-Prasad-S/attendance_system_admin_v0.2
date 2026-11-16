import '../models/auth_user_model.dart';
import '../models/user_authorization_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<AuthUserModel> login(AuthUserModel user);

  Future<AuthUserModel> signup(AuthUserModel user);

  Future<UserAuthorizationModel?> getUserAuthorization(String userId);

  Future<UserAuthorizationModel> createUserAuthorization(
    UserAuthorizationModel authorization,
  );

  Future<void> signOut();
}
