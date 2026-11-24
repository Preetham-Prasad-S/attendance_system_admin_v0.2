import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../staff/domain/entity/staff_entity.dart';
import '../../../staff/domain/repository/staff_repository.dart';
import '../entity/auth_user_entity.dart';
import '../entity/user_authorization_entity.dart';
import '../repository/auth_repository.dart';

class RegisterUserUseCase extends Usecase<AuthUserEntity, RegisterUserParams> {
  const RegisterUserUseCase({
    required this.authRepository,
    required this.staffRepository,
  });

  final AuthRepository authRepository;
  final StaffRepository staffRepository;

  @override
  Future<Either<AppFailure, AuthUserEntity>> call(
    RegisterUserParams params,
  ) async {
    final signUpResult = await authRepository.signup(
      AuthUserEntity(email: params.email, password: params.password),
    );

    return signUpResult.fold((failure) => Left(failure), (user) async {
      final userId = user.id;
      if (userId == null) {
        return const Left(
          AppAuthFailure(message: 'Unable to identify the new account.'),
        );
      }

      final staffResult = await staffRepository.linkUserToStaff(
        staffId: params.staff.id,
        userId: userId,
      );

      final staffFailure = staffResult.fold<AppFailure?>(
        (failure) => failure,
        (_) => null,
      );
      if (staffFailure != null) return Left(staffFailure);

      final authorizationResult = await authRepository.linkUserToAuthorization(
        authorizationId: params.authorization.id,
        userId: userId,
      );

      return authorizationResult.fold(
        (failure) => Left(failure),
        (_) => Right(user),
      );
    });
  }
}

class RegisterUserParams {
  const RegisterUserParams({
    required this.email,
    required this.password,
    required this.staff,
    required this.authorization,
  });

  final String email;
  final String password;
  final StaffEntity staff;
  final UserAuthorizationEntity authorization;
}
