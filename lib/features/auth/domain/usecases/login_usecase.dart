import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase.dart';
import '../entity/auth_user_entity.dart';
import '../repository/auth_repository.dart';

class LoginUseCase extends Usecase<AuthUserEntity, LoginUsecaseParams> {
  const LoginUseCase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<AppFailure, AuthUserEntity>> call(LoginUsecaseParams params) =>
      repository.login(
        AuthUserEntity(email: params.email, password: params.password),
      );
}

class LoginUsecaseParams {
  const LoginUsecaseParams({required this.email, required this.password});

  final String email;
  final String password;
}
