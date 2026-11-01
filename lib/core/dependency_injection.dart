import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../features/auth/data/datasource/auth_remote_data_source.dart';
import '../features/auth/data/datasource/auth_remote_data_source_impl.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/presentation/controller/auth_controller.dart';
import '../features/auth/presentation/controller/auth_state.dart';

final authStateChangesProvider = StreamProvider<supabase.AuthState>((
  ref,
) async* {
  final auth = supabase.Supabase.instance.client.auth;

  yield supabase.AuthState(
    supabase.AuthChangeEvent.initialSession,
    auth.currentSession,
  );
  yield* auth.onAuthStateChange;
});

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(client: supabase.Supabase.instance.client);
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
  );
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  return LoginUseCase(repository: ref.watch(authRepositoryProvider));
});

final authControllerProvider = NotifierProvider<AuthController, AuthState>(() {
  return AuthController(loginUseCaseProvider: loginUseCaseProvider);
});
