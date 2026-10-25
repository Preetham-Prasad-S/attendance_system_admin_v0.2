import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException, SupabaseClient;

import '../../../core/error/app_exception.dart';
import '../domain/entity/user_entity.dart';
import 'auth_remote_data_source.dart';
import 'models/auth_user_model.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<UserEntity> login(AuthUserModel user) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );

      final authUser = response.user;

      if (authUser == null) {
        throw const AuthException('Unable to sign in');
      }

      return UserEntity(
        email: authUser.email ?? user.email,
        password: user.password,
      );
    } on AuthException catch (error) {
      throw AppAuthException(message: error.message);
    } catch (error) {
      throw AppUnknownException(message: error.toString());
    }
  }
}
