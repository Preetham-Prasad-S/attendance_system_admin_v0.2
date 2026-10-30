import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../entity/auth_user_entity.dart';

abstract interface class AuthRepository {
  Future<Either<AppFailure, AuthUserEntity>> login(AuthUserEntity user);
}
