import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entity/staff_entity.dart';

enum StaffStatus { active, onLeave }

const allDepartmentsLabel = 'All Departments';
const allStatusesLabel = 'All Statuses';
const activeStatusLabel = 'Active';
const onLeaveStatusLabel = 'On Leave';

const staffAvatarPalette = <Color>[
  AppColors.avatarBlue,
  AppColors.avatarViolet,
  AppColors.avatarEmerald,
  AppColors.avatarOrange,
  AppColors.avatarPink,
];

class StaffMember {
  const StaffMember({
    required this.name,
    required this.employeeId,
    required this.department,
    required this.role,
    required this.email,
    required this.phone,
    required this.status,
    required this.avatarColor,
  });

  factory StaffMember.fromEntity(
    StaffEntity entity, {
    required Color avatarColor,
  }) {
    return StaffMember(
      name: entity.name,
      employeeId: entity.staffId,
      department: entity.department,
      role: entity.position,
      email: entity.email,
      phone: entity.phoneNo?.toString() ?? '—',
      // The staff table has no status column yet, so every record is
      // presented as active until the backend provides one.
      status: StaffStatus.active,
      avatarColor: avatarColor,
    );
  }

  final String name;
  final String employeeId;
  final String department;
  final String role;
  final String email;
  final String phone;
  final StaffStatus status;
  final Color avatarColor;

  String get initials {
    final parts = name
        .replaceAll('.', '')
        .split(' ')
        .where((part) => part != 'Dr' && part != 'Prof' && part.isNotEmpty)
        .take(2);

    return parts.map((part) => part[0]).join().toUpperCase();
  }
}

const staffStatusOptions = <String>[
  allStatusesLabel,
  activeStatusLabel,
  onLeaveStatusLabel,
];

List<String> staffDepartmentOptionsFor(List<StaffMember> members) => [
  allDepartmentsLabel,
  ...{for (final member in members) member.department},
];

List<StaffMember> filterStaffMembers(
  List<StaffMember> members, {
  String query = '',
  String department = allDepartmentsLabel,
  String status = allStatusesLabel,
}) {
  final normalizedQuery = query.trim().toLowerCase();

  return members.where((member) {
    final matchesQuery =
        normalizedQuery.isEmpty ||
        member.name.toLowerCase().contains(normalizedQuery) ||
        member.employeeId.toLowerCase().contains(normalizedQuery) ||
        member.email.toLowerCase().contains(normalizedQuery);
    final matchesDepartment =
        department == allDepartmentsLabel || member.department == department;
    final matchesStatus = switch (status) {
      activeStatusLabel => member.status == StaffStatus.active,
      onLeaveStatusLabel => member.status == StaffStatus.onLeave,
      _ => true,
    };

    return matchesQuery && matchesDepartment && matchesStatus;
  }).toList();
}
