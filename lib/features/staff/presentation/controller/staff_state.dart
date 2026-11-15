import '../../domain/entity/staff_entity.dart';

const allDepartmentsLabel = 'All Departments';
const allStatusesLabel = 'All Statuses';
const activeStatusLabel = 'Active';
const inactiveStatusLabel = 'Inactive';

const staffStatusOptions = <String>[
  allStatusesLabel,
  activeStatusLabel,
  inactiveStatusLabel,
];

class StaffState {
  const StaffState({
    required this.members,
    this.searchQuery = '',
    this.department = allDepartmentsLabel,
    this.status = allStatusesLabel,
  });

  final List<StaffEntity> members;
  final String searchQuery;
  final String department;
  final String status;

  List<StaffEntity> get visibleMembers {
    final normalizedQuery = searchQuery.trim().toLowerCase();

    return members.where((member) {
      final matchesQuery =
          normalizedQuery.isEmpty ||
          member.name.toLowerCase().contains(normalizedQuery) ||
          member.staffId.toLowerCase().contains(normalizedQuery) ||
          member.email.toLowerCase().contains(normalizedQuery);
      final matchesDepartment =
          department == allDepartmentsLabel || member.department == department;
      final matchesStatus = switch (status) {
        activeStatusLabel => member.status,
        inactiveStatusLabel => !member.status,
        _ => true,
      };

      return matchesQuery && matchesDepartment && matchesStatus;
    }).toList();
  }

  List<String> get departmentOptions => [
    allDepartmentsLabel,
    ...{for (final member in members) member.department},
  ];

  StaffState copyWith({
    List<StaffEntity>? members,
    String? searchQuery,
    String? department,
    String? status,
  }) {
    return StaffState(
      members: members ?? this.members,
      searchQuery: searchQuery ?? this.searchQuery,
      department: department ?? this.department,
      status: status ?? this.status,
    );
  }
}
