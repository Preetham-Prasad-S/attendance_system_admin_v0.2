import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entity/staff_entity.dart';

abstract interface class StaffRepository {
  Future<Either<AppFailure, List<StaffEntity>>> getStaff();

  Future<Either<AppFailure, StaffEntity>> getStaffById(int id);

  Future<Either<AppFailure, StaffEntity>> createStaff(StaffEntity staff);

  Future<Either<AppFailure, StaffEntity>> updateStaff(StaffEntity staff);

  Future<Either<AppFailure, void>> deleteStaff(int id);
}