import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/staff_repository.dart';

class DeleteStaffUseCase extends Usecase<void, String> {
  const DeleteStaffUseCase({required this.repository});

  final StaffRepository repository;

  @override
  Future<Either<AppFailure, void>> call(String id) =>
      repository.deleteStaff(id);
}
