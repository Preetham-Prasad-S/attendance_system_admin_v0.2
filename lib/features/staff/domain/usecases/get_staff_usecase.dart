import 'package:fpdart/fpdart.dart';

import '../../../../core/usecase/no_params.dart';
import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../../domain/entity/staff_entity.dart';
import '../repository/staff_repository.dart';

class GetStaffUseCase extends Usecase<List<StaffEntity>, NoParams> {
  const GetStaffUseCase({required this.repository});

  final StaffRepository repository;

  @override
  Future<Either<AppFailure, List<StaffEntity>>> call(NoParams params) =>
      repository.getStaff();
}