import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/app_exception.dart';
import '../../../../core/error/app_failure.dart';
import '../../../../core/usecase/no_params.dart';
import '../../domain/entity/staff_entity.dart';
import '../../domain/usecases/delete_staff_usecase.dart';
import '../../domain/usecases/get_staff_usecase.dart';
import '../../domain/usecases/update_staff_usecase.dart';
import 'staff_state.dart';

class StaffController extends AsyncNotifier<StaffState> {
  StaffController({
    required Provider<GetStaffUseCase> getStaffUseCaseProvider,
    required Provider<UpdateStaffUseCase> updateStaffUseCaseProvider,
    required Provider<DeleteStaffUseCase> deleteStaffUseCaseProvider,
  }) : _getStaffUseCaseProvider = getStaffUseCaseProvider,
       _updateStaffUseCaseProvider = updateStaffUseCaseProvider,
       _deleteStaffUseCaseProvider = deleteStaffUseCaseProvider;

  final Provider<GetStaffUseCase> _getStaffUseCaseProvider;
  final Provider<UpdateStaffUseCase> _updateStaffUseCaseProvider;
  final Provider<DeleteStaffUseCase> _deleteStaffUseCaseProvider;

  @override
  Future<StaffState> build() async {
    final useCase = ref.watch(_getStaffUseCaseProvider);
    final entities = await _fetchStaff(useCase);

    return StaffState(members: entities);
  }

  void updateSearchQuery(String query) {
    _updateFilters(searchQuery: query);
  }

  void updateDepartment(String department) {
    _updateFilters(department: department);
  }

  void updateStatus(String status) {
    _updateFilters(status: status);
  }

  Future<void> refreshStaff() async {
    final current = state.valueOrNull;

    state = current == null
        ? const AsyncLoading<StaffState>()
        : const AsyncLoading<StaffState>().copyWithPrevious(state);

    final useCase = ref.read(_getStaffUseCaseProvider);

    state = await AsyncValue.guard(() async {
      final entities = await _fetchStaff(useCase);

      return StaffState(
        members: entities,
        searchQuery: current?.searchQuery ?? '',
        department: current?.department ?? allDepartmentsLabel,
        status: current?.status ?? allStatusesLabel,
      );
    });
  }

  Future<AppFailure?> setStaffStatus(
    StaffEntity staff, {
    required bool status,
  }) async {
    final result = await ref.read(_updateStaffUseCaseProvider)(
      staff.copyWith(status: status),
    );

    final failure = result.fold<AppFailure?>((failure) => failure, (_) => null);
    if (failure != null) return failure;

    await refreshStaff();
    return null;
  }

  Future<AppFailure?> deleteStaff(StaffEntity staff) async {
    final result = await ref.read(_deleteStaffUseCaseProvider)(staff.id);

    final failure = result.fold<AppFailure?>((failure) => failure, (_) => null);
    if (failure != null) return failure;

    final current = state.valueOrNull;
    if (current != null) {
      state = AsyncData(
        current.copyWith(
          members: current.members
              .where((member) => member.id != staff.id)
              .toList(),
        ),
      );
    }

    await refreshStaff();
    return null;
  }

  Future<List<StaffEntity>> _fetchStaff(GetStaffUseCase useCase) async {
    final result = await useCase(const NoParams());

    return result.fold(
      (failure) => throw AppUnknownException(message: failure.toString()),
      (staff) => staff,
    );
  }

  void _updateFilters({
    String? searchQuery,
    String? department,
    String? status,
  }) {
    final current = state.valueOrNull;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(
        searchQuery: searchQuery ?? current.searchQuery,
        department: department ?? current.department,
        status: status ?? current.status,
      ),
    );
  }
}
