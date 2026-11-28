import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

import '../features/auth/data/datasource/auth_remote_data_source.dart';
import '../features/auth/data/datasource/auth_remote_data_source_impl.dart';
import '../features/auth/data/repository/auth_repository_impl.dart';
import '../features/auth/domain/repository/auth_repository.dart';
import '../features/auth/domain/usecases/check_login_access_usecase.dart';
import '../features/auth/domain/usecases/get_staff_authorizations_usecase.dart';
import '../features/auth/domain/usecases/get_user_authorization_usecase.dart';
import '../features/auth/domain/usecases/login_usecase.dart';
import '../features/auth/domain/usecases/register_user_usecase.dart';
import '../features/auth/domain/usecases/sign_out_usecase.dart';
import '../features/auth/presentation/controller/auth_controller.dart';
import '../features/auth/presentation/controller/auth_state.dart';

import '../features/staff/data/datasource/staff_remote_data_source_impl.dart';
import '../features/staff/data/repository/staff_repository_impl.dart';
import '../features/staff/domain/repository/staff_repository.dart';
import '../features/staff/domain/usecases/create_staff_usecase.dart';
import '../features/staff/domain/usecases/create_staff_with_authorization_usecase.dart';
import '../features/staff/domain/usecases/delete_staff_usecase.dart';
import '../features/staff/domain/usecases/get_staff_usecase.dart';
import '../features/staff/domain/usecases/get_staff_by_id_usecase.dart';
import '../features/staff/domain/usecases/update_staff_usecase.dart';
import '../features/staff/presentation/controller/staff_controller.dart';
import '../features/staff/presentation/controller/staff_state.dart';

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

final getUserAuthorizationUseCaseProvider =
    Provider<GetUserAuthorizationUseCase>((ref) {
      return GetUserAuthorizationUseCase(
        repository: ref.watch(authRepositoryProvider),
      );
    });

final getStaffAuthorizationsUseCaseProvider =
    Provider<GetStaffAuthorizationsUseCase>((ref) {
      return GetStaffAuthorizationsUseCase(
        repository: ref.watch(authRepositoryProvider),
      );
    });

final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(repository: ref.watch(authRepositoryProvider));
});

final checkLoginAccessUseCaseProvider = Provider<CheckLoginAccessUseCase>((
  ref,
) {
  return CheckLoginAccessUseCase(
    authRepository: ref.watch(authRepositoryProvider),
    staffRepository: ref.watch(staffRepositoryProvider),
  );
});

final registerUserUseCaseProvider = Provider<RegisterUserUseCase>((ref) {
  return RegisterUserUseCase(
    authRepository: ref.watch(authRepositoryProvider),
    staffRepository: ref.watch(staffRepositoryProvider),
  );
});

final authControllerProvider = NotifierProvider<AuthController, AuthState>(() {
  return AuthController(
    loginUseCaseProvider: loginUseCaseProvider,
    checkLoginAccessUseCaseProvider: checkLoginAccessUseCaseProvider,
    getUserAuthorizationUseCaseProvider: getUserAuthorizationUseCaseProvider,
    registerUserUseCaseProvider: registerUserUseCaseProvider,
  );
});

final staffRepositoryProvider = Provider<StaffRepository>((ref) {
  return StaffRepositoryImpl(
    remoteDataSource: StaffRemoteDataSourceImpl(
      client: supabase.Supabase.instance.client,
    ),
  );
});

final getStaffUseCaseProvider = Provider<GetStaffUseCase>((ref) {
  return GetStaffUseCase(repository: ref.watch(staffRepositoryProvider));
});

final getStaffByIdUseCaseProvider = Provider<GetStaffByIdUseCase>((ref) {
  return GetStaffByIdUseCase(repository: ref.watch(staffRepositoryProvider));
});

final createStaffUseCaseProvider = Provider<CreateStaffUseCase>((ref) {
  return CreateStaffUseCase(repository: ref.watch(staffRepositoryProvider));
});

final createStaffWithAuthorizationUseCaseProvider =
    Provider<CreateStaffWithAuthorizationUseCase>((ref) {
      return CreateStaffWithAuthorizationUseCase(
        staffRepository: ref.watch(staffRepositoryProvider),
        authRepository: ref.watch(authRepositoryProvider),
      );
    });

final updateStaffUseCaseProvider = Provider<UpdateStaffUseCase>((ref) {
  return UpdateStaffUseCase(repository: ref.watch(staffRepositoryProvider));
});

final deleteStaffUseCaseProvider = Provider<DeleteStaffUseCase>((ref) {
  return DeleteStaffUseCase(repository: ref.watch(staffRepositoryProvider));
});

final staffControllerProvider =
    AsyncNotifierProvider<StaffController, StaffState>(() {
      return StaffController(
        getStaffUseCaseProvider: getStaffUseCaseProvider,
        getStaffAuthorizationsUseCaseProvider:
            getStaffAuthorizationsUseCaseProvider,
        updateStaffUseCaseProvider: updateStaffUseCaseProvider,
        deleteStaffUseCaseProvider: deleteStaffUseCaseProvider,
      );
    });
