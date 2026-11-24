import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../entity/auth_user_entity.dart';
import '../entity/user_authorization_entity.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, AuthUserEntity>> login(AuthUserEntity user);

  Future<Either<AppFailure, AuthUserEntity>> signup(AuthUserEntity user);

  Future<Either<AppFailure, UserAuthorizationEntity?>> getUserAuthorization(
    String userId,
  );

  Future<Either<AppFailure, UserAuthorizationEntity?>>
  getUserAuthorizationByStaffId(String staffId);

  Future<Either<AppFailure, UserAuthorizationEntity>> linkUserToAuthorization({
    required String authorizationId,
    required String userId,
  });

  Future<Either<AppFailure, List<UserAuthorizationEntity>>>
  getStaffAuthorizations();

  Future<Either<AppFailure, UserAuthorizationEntity>> createUserAuthorization(
    UserAuthorizationEntity authorization,
  );

  Future<Either<AppFailure, void>> signOut();
}
