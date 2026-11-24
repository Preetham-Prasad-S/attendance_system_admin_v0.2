import '../models/staff_model.dart';

abstract interface class StaffRemoteDataSource {
  Future<List<StaffModel>> getStaff();

  Future<StaffModel> getStaffById(String id);

  Future<StaffModel?> getStaffByIdentifier(String identifier);

  Future<StaffModel> linkUserToStaff({
    required String staffId,
    required String userId,
  });

  Future<StaffModel> createStaff(StaffModel staff);

  Future<StaffModel> updateStaff(StaffModel staff);

  Future<void> deleteStaff(String id);
}
