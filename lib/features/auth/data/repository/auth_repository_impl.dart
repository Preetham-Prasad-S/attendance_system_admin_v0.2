import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../../domain/entity/auth_user_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({required this.remoteDataSource});

  final AuthRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, AuthUserEntity>> login(AuthUserEntity user) async {
    try {
      final result = await remoteDataSource.login(user.toModel());

      return Right(AuthUserEntity.fromModel(result));
    } catch (error) {
      return Left(AppAuthFailure(message: error.toString()));
    }
  }
}
