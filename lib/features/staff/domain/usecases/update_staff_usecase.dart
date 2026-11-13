import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/staff_entity.dart';
import '../repository/staff_repository.dart';

class UpdateStaffUseCase extends Usecase<StaffEntity, StaffEntity> {
  const UpdateStaffUseCase({required this.repository});

  final StaffRepository repository;

  @override
  Future<Either<AppFailure, StaffEntity>> call(StaffEntity staff) =>
      repository.updateStaff(staff);
}