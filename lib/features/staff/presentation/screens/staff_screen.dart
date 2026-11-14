import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entity/staff_entity.dart';
import '../models/staff_member.dart';
import '../widgets/add_faculty_dialog/add_faculty_dialog.dart';
import '../widgets/faculty_table.dart';
import '../widgets/filter_bar.dart';
import '../widgets/page_header.dart';

class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});

  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  String _searchQuery = '';
  String _department = allDepartmentsLabel;
  String _status = allStatusesLabel;

  void _handleAddFaculty(BuildContext context) {
    showAddFacultyDialog(context);
  }

  void _handleSearchChanged(String query) {
    setState(() => _searchQuery = query);
  }

  void _handleDepartmentChanged(String department) {
    setState(() => _department = department);
  }

  void _handleStatusChanged(String status) {
    setState(() => _status = status);
  }

  @override
  Widget build(BuildContext context) {
    final staffAsync = ref.watch(staffListProvider);
    final entities = staffAsync.valueOrNull ?? const <StaffEntity>[];
    final allMembers = <StaffMember>[
      for (var index = 0; index < entities.length; index++)
        StaffMember.fromEntity(
          entities[index],
          avatarColor: staffAvatarPalette[index % staffAvatarPalette.length],
        ),
    ];
    final visibleMembers = filterStaffMembers(
      allMembers,
      query: _searchQuery,
      department: _department,
      status: _status,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(onAddFaculty: () => _handleAddFaculty(context)),
              const SizedBox(height: 22),
              FilterBar(
                departmentOptions: staffDepartmentOptionsFor(allMembers),
                onSearchChanged: _handleSearchChanged,
                onDepartmentChanged: _handleDepartmentChanged,
                onStatusChanged: _handleStatusChanged,
                totalRecords: visibleMembers.length,
              ),
              const SizedBox(height: 18),
              staffAsync.when(
                data: (staff) {
                  if (staff.isEmpty) {
                    return const _NoStaffCreated();
                  }

                  return FacultyTable(members: visibleMembers);
                },
                loading: () => const _StaffLoading(),
                error: (error, _) => _StaffLoadError(
                  message: error.toString(),
                  onRetry: () => ref.invalidate(staffListProvider),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoStaffCreated extends StatelessWidget {
  const _NoStaffCreated();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: Text(
          'No staff created',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.muted,
          ),
        ),
      ),
    );
  }
}

class _StaffLoading extends StatelessWidget {
  const _StaffLoading();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 48),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2.4,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

class _StaffLoadError extends StatelessWidget {
  const _StaffLoadError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 30,
            color: AppColors.danger,
          ),
          const SizedBox(height: 10),
          const Text(
            'Failed to load staff',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}
