import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entity/staff_entity.dart';

abstract interface class StaffRepository {
  Future<Either<AppFailure, List<StaffEntity>>> getStaff();

  Future<Either<AppFailure, StaffEntity>> getStaffById(String id);

  Future<Either<AppFailure, StaffEntity?>> getStaffByIdentifier(
    String identifier,
  );

  Future<Either<AppFailure, StaffEntity>> linkUserToStaff({
    required String staffId,
    required String userId,
  });

  Future<Either<AppFailure, StaffEntity>> createStaff(StaffEntity staff);

  Future<Either<AppFailure, StaffEntity>> updateStaff(StaffEntity staff);

  Future<Either<AppFailure, void>> deleteStaff(String id);
}
