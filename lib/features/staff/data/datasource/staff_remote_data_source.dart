import '../models/staff_model.dart';

abstract interface class StaffRemoteDataSource {
  Future<List<StaffModel>> getStaff();

  Future<StaffModel> getStaffById(String id);

  Future<StaffModel> createStaff(StaffModel staff);

  Future<StaffModel> updateStaff(StaffModel staff);

  Future<void> deleteStaff(String id);
}
