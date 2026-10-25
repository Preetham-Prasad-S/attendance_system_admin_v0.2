import '../domain/entity/user_entity.dart';
import 'models/auth_user_model.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserEntity> login(AuthUserModel user);
}
