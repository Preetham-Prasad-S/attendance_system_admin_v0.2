import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../staff/domain/repository/staff_repository.dart';
import '../entity/login_access.dart';
import '../repository/auth_repository.dart';

const String notAuthorizedLoginMessage =
    'Your account is not authorized to access the admin panel.';

class CheckLoginAccessUseCase extends Usecase<LoginAccess, String> {
  const CheckLoginAccessUseCase({
    required this.authRepository,
    required this.staffRepository,
  });

  final AuthRepository authRepository;
  final StaffRepository staffRepository;

  @override
  Future<Either<AppFailure, LoginAccess>> call(String identifier) async {
    final staffResult = await staffRepository.getStaffByIdentifier(
      identifier.trim(),
    );

    return staffResult.fold((failure) => Left(failure), (staff) async {
      if (staff == null) {
        return const Right(StaffNotFound());
      }

      final authorizationResult = await authRepository
          .getUserAuthorizationByStaffId(staff.id);

      return authorizationResult.fold((failure) => Left(failure), (
        authorization,
      ) {
        if (authorization == null || !authorization.canAccessAdminPanel) {
          return const Right(LoginDenied(message: notAuthorizedLoginMessage));
        }

        if (staff.userId == null && authorization.userId == null) {
          return Right(
            RegistrationRequired(staff: staff, authorization: authorization),
          );
        }

        return Right(LoginAllowed(staff: staff, authorization: authorization));
      });
    });
  }
}
