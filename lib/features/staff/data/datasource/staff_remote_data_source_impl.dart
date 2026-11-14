import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/error/app_exception.dart';
import '../models/staff_model.dart';
import 'staff_remote_data_source.dart';

class StaffRemoteDataSourceImpl implements StaffRemoteDataSource {
  const StaffRemoteDataSourceImpl({required this.client});

  final SupabaseClient client;

  @override
  Future<List<StaffModel>> getStaff() async {
    try {
      final response = await client.from('staff').select();

      if (response.isEmpty) {
        return [];
      }

      return (response as List)
          .map((json) => StaffModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<StaffModel> getStaffById(int id) async {
    try {
      final response = await client
          .from('staff')
          .select()
          .eq('id', id)
          .single();

      return StaffModel.fromJson(response);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<StaffModel> createStaff(StaffModel staff) async {
    try {
      final response = await client
          .from('staff')
          .insert(staff.toInsertJson())
          .select();

      if (response.isNotEmpty) {
        return StaffModel.fromJson(response.first);
      }

      throw const AppAuthException(message: 'Failed to create staff');
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<StaffModel> updateStaff(StaffModel staff) async {
    try {
      final response = await client
          .from('staff')
          .update(staff.toJson())
          .eq('id', staff.id)
          .select();

      if (response.isNotEmpty) {
        return StaffModel.fromJson(response.first);
      }

      throw const AppAuthException(message: 'Failed to update staff');
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }

  @override
  Future<void> deleteStaff(int id) async {
    try {
      await client.from('staff').delete().eq('id', id);
    } catch (error) {
      throw AppAuthException(message: error.toString());
    }
  }
}
