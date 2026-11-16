import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../../../core/usecase/usecase.dart';
import '../repository/auth_repository.dart';

class SignOutUseCase extends Usecase<void, NoParams> {
  const SignOutUseCase({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<AppFailure, void>> call(NoParams params) =>
      repository.signOut();
}
