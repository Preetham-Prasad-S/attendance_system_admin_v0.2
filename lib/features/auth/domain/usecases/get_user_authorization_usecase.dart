import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/user_authorization_entity.dart';
import '../repository/auth_repository.dart';

class GetUserAuthorizationUseCase
    extends Usecase<UserAuthorizationEntity?, String> {
  const GetUserAuthorizationUseCase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<AppFailure, UserAuthorizationEntity?>> call(String userId) =>
      repository.getUserAuthorization(userId);
}
