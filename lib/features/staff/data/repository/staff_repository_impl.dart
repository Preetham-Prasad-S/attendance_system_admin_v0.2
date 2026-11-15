import 'package:fpdart/fpdart.dart';

import '../../../../core/error/app_failure.dart';
import '../datasource/staff_remote_data_source.dart';
import '../../domain/entity/staff_entity.dart';
import '../../domain/repository/staff_repository.dart';

class StaffRepositoryImpl implements StaffRepository {
  const StaffRepositoryImpl({required this.remoteDataSource});

  final StaffRemoteDataSource remoteDataSource;

  @override
  Future<Either<AppFailure, List<StaffEntity>>> getStaff() async {
    try {
      final result = await remoteDataSource.getStaff();
      return Right(
        result.map((model) => StaffEntity.fromModel(model)).toList(),
      );
    } catch (error) {
      return Left(AppAuthFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffEntity>> getStaffById(String id) async {
    try {
      final result = await remoteDataSource.getStaffById(id);
      return Right(StaffEntity.fromModel(result));
    } catch (error) {
      return Left(AppAuthFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffEntity>> createStaff(StaffEntity staff) async {
    try {
      final result = await remoteDataSource.createStaff(staff.toModel());
      return Right(StaffEntity.fromModel(result));
    } catch (error) {
      return Left(AppAuthFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<AppFailure, StaffEntity>> updateStaff(StaffEntity staff) async {
    try {
      final result = await remoteDataSource.updateStaff(staff.toModel());
      return Right(StaffEntity.fromModel(result));
    } catch (error) {
      return Left(AppAuthFailure(message: error.toString()));
    }
  }

  @override
  Future<Either<AppFailure, void>> deleteStaff(String id) async {
    try {
      await remoteDataSource.deleteStaff(id);
      return const Right(null);
    } catch (error) {
      return Left(AppAuthFailure(message: error.toString()));
    }
  }
}
