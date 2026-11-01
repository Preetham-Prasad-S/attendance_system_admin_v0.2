import 'package:fpdart/fpdart.dart';

import '../error/app_failure.dart';

abstract class Usecase<UsecaseType, UsecaseParams> {
  const Usecase();

  Future<Either<AppFailure, UsecaseType>> call(UsecaseParams params);
}
