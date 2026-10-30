import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException, SupabaseClient;

import '../../../../core/error/app_exception.dart';
import '../models/auth_user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  const AuthRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<AuthUserModel> login(AuthUserModel user) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: user.email,
        password: user.password,
      );

      final authUser = response.user;

      if (authUser == null) {
        throw const AppAuthException(message: 'Unable to sign in');
      }

      return AuthUserModel(
        email: authUser.email ?? user.email,
        password: user.password,
      );
    } on AuthException catch (error) {
      throw AppAuthException(message: error.message);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<AuthUserModel> signup(AuthUserModel user) async {
    try {
      final response = await client.auth.signUp(
        email: user.email,
        password: user.password,
      );

      final authUser = response.user;

      if (authUser == null) {
        throw const AppAuthException(message: 'Unable to sign up');
      }

      return AuthUserModel(
        email: authUser.email ?? user.email,
        password: user.password,
      );
    } on AuthException catch (error) {
      throw AppAuthException(message: error.message);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }
}
