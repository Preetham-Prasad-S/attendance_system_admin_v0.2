import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../auth/domain/entity/user_authorization_entity.dart';
import '../../../auth/domain/repository/auth_repository.dart';
import '../entity/staff_entity.dart';
import '../repository/staff_repository.dart';

class CreateStaffWithAuthorizationUseCase
    extends Usecase<StaffEntity, CreateStaffWithAuthorizationParams> {
  const CreateStaffWithAuthorizationUseCase({
    required this.staffRepository,
    required this.authRepository,
  });

  final StaffRepository staffRepository;
  final AuthRepository authRepository;

  @override
  Future<Either<AppFailure, StaffEntity>> call(
    CreateStaffWithAuthorizationParams params,
  ) async {
    final staffResult = await staffRepository.createStaff(params.staff);

    return staffResult.fold<Future<Either<AppFailure, StaffEntity>>>(
      (failure) async => Left(failure),
      (staff) async {
        final authorization = UserAuthorizationEntity(
          id: const Uuid().v7(),
          userStaffId: staff.id,
          authorityLevel: params.authorityLevel,
        );

        final authorizationResult = await authRepository
            .createUserAuthorization(authorization);

        return authorizationResult
            .fold<Future<Either<AppFailure, StaffEntity>>>((failure) async {
              await staffRepository.deleteStaff(staff.id);
              return Left(failure);
            }, (_) async => Right(staff));
      },
    );
  }
}

class CreateStaffWithAuthorizationParams {
  const CreateStaffWithAuthorizationParams({
    required this.staff,
    required this.authorityLevel,
  });

  final StaffEntity staff;
  final String authorityLevel;
}
