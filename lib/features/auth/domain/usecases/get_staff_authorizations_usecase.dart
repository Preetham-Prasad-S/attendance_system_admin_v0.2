import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_authorization_entity.dart';
import '../repository/auth_repository.dart';

class GetStaffAuthorizationsUseCase
    extends Usecase<List<UserAuthorizationEntity>, NoParams> {
  const GetStaffAuthorizationsUseCase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<AppFailure, List<UserAuthorizationEntity>>> call(
    NoParams params,
  ) => repository.getStaffAuthorizations();
}
