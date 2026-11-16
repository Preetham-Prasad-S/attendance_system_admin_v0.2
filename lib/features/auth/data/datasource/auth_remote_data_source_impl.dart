import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthException, SupabaseClient;

import '../../../../core/error/app_exception.dart';
import '../models/auth_user_model.dart';
import '../models/user_authorization_model.dart';
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

  @override
  Future<UserAuthorizationModel?> getUserAuthorization(String userId) async {
    try {
      final response = await client
          .from('user_authorization')
          .select()
          .eq('user_id', userId)
          .maybeSingle();

      if (response == null) return null;

      return UserAuthorizationModel.fromJson(response);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<UserAuthorizationModel> createUserAuthorization(
    UserAuthorizationModel authorization,
  ) async {
    try {
      final response = await client
          .from('user_authorization')
          .insert(authorization.toJson())
          .select();

      if (response.isEmpty) {
        throw const AppAuthException(
          message: 'Failed to create user authorization',
        );
      }

      return UserAuthorizationModel.fromJson(response.first);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await client.auth.signOut();
    } on AuthException catch (error) {
      throw AppAuthException(message: error.message);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }
}
