import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  final _selectedIds = <String>{};

  int _currentPage = 1;

  late final List<_StaffMember> _members = _buildMembers();

  List<_StaffMember> _buildMembers() {
    final random = Random();

    return <_StaffMember>[
      _StaffMember(
        name: 'Dr. Rajeshwari Sengupta',
        employeeId: 'EMP-CS-041',
        department: 'Computer Science & Eng',
        role: 'Professor & Head of Dept',
        email: 'r.sengupta@campus.edu',
        phone: '+1 (555) 234-8801',
        status: _StaffStatus.active,
        avatarGradient: _randomGradient(random),
      ),
      _StaffMember(
        name: 'Prof. Marcus Thorne',
        employeeId: 'EMP-CS-112',
        department: 'Computer Science & Eng',
        role: 'Associate Professor',
        email: 'm.thorne@campus.edu',
        phone: '+1 (555) 489-1029',
        status: _StaffStatus.active,
        avatarGradient: _randomGradient(random),
      ),
      _StaffMember(
        name: 'Dr. Elena Rostova',
        employeeId: 'EMP-CS-204',
        department: 'Computer Science & Eng',
        role: 'Assistant Professor',
        email: 'e.rostova@campus.edu',
        phone: '+1 (555) 762-3804',
        status: _StaffStatus.active,
        avatarGradient: _randomGradient(random),
      ),
      _StaffMember(
        name: 'David K. Chen',
        employeeId: 'EMP-CS-155',
        department: 'Computer Science & Eng',
        role: 'Senior Lab Instructor',
        email: 'd.chen@campus.edu',
        phone: '+1 (555) 881-9923',
        status: _StaffStatus.onLeave,
        avatarGradient: _randomGradient(random),
      ),
      _StaffMember(
        name: 'Dr. Amara Okafor',
        employeeId: 'EMP-CS-068',
        department: 'Computer Science & Eng',
        role: 'Associate Professor',
        email: 'a.okafor@campus.edu',
        phone: '+1 (555) 672-9045',
        status: _StaffStatus.active,
        avatarGradient: _randomGradient(random),
      ),
    ];
  }

  List<Color> _randomGradient(Random random) {
    final start = Color.lerp(
      AppColors.primary,
      AppColors.brand,
      random.nextDouble(),
    )!;
    final end = Color.lerp(
      AppColors.brand,
      AppColors.navy,
      random.nextDouble(),
    )!;
    return [start, end];
  }

  bool get _allMembersSelected =>
      _members.isNotEmpty &&
      _members.every((member) => _selectedIds.contains(member.employeeId));

  bool get _someMembersSelected =>
      _members.any((member) => _selectedIds.contains(member.employeeId));

  void _toggleAll() {
    final memberIds = _members.map((member) => member.employeeId).toSet();

    setState(() {
      if (_allMembersSelected) {
        _selectedIds.removeAll(memberIds);
      } else {
        _selectedIds.addAll(memberIds);
      }
    });
  }

  void _toggleMember(String employeeId) {
    setState(() {
      if (_selectedIds.contains(employeeId)) {
        _selectedIds.remove(employeeId);
      } else {
        _selectedIds.add(employeeId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(color: AppColors.canvas, child: _buildContent());
  }

  Widget _buildContent() {
    final members = _members;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _PageHeader(),
          const SizedBox(height: 12),
          Expanded(
            child: _FacultyTable(
              members: members,
              selectedIds: _selectedIds,
              allSelected: _allMembersSelected,
              someSelected: _someMembersSelected,
              onToggleAll: _toggleAll,
              onToggleMember: _toggleMember,
            ),
          ),
          const SizedBox(height: 8),
          _Pagination(
            totalCount: 48,
            visibleCount: members.length,
            currentPage: _currentPage,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
            },
          ),
        ],
      ),
    );
  }
}

enum _StaffStatus { active, onLeave }

class _StaffMember {
  const _StaffMember({
    required this.name,
    required this.employeeId,
    required this.department,
    required this.role,
    required this.email,
    required this.phone,
    required this.status,
    required this.avatarGradient,
  });

  final String name;
  final String employeeId;
  final String department;
  final String role;
  final String email;
  final String phone;
  final _StaffStatus status;
  final List<Color> avatarGradient;

  String get initials {
    final words = name
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty && !word.endsWith('.'))
        .toList();

    if (words.length >= 2) {
      return '${words.first[0]}${words.last[0]}'.toUpperCase();
    }

    return name[0].toUpperCase();
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.size,
    required this.initials,
    required this.gradient,
    this.statusColor,
  });

  final double size;
  final String initials;
  final List<Color> gradient;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              initials,
              style: TextStyle(
                fontSize: size * 0.34,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
          if (statusColor != null)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _PageHeader extends StatelessWidget {
  const _PageHeader();

  @override
  Widget build(BuildContext context) {
    final actions = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _PageActionButton(
          icon: Icons.download_rounded,
          label: 'Export',
          onPressed: () {},
        ),
        const SizedBox(width: 8),
        _PageActionButton(
          icon: Icons.add_rounded,
          label: 'Add Faculty',
          primary: true,
          onPressed: () {},
        ),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 560) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const _PageHeading(),
              const SizedBox(height: 10),
              Align(alignment: Alignment.centerRight, child: actions),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(child: _PageHeading()),
            const SizedBox(width: 16),
            actions,
          ],
        );
      },
    );
  }
}

class _PageHeading extends StatelessWidget {
  const _PageHeading();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(
              child: Text(
                'Faculty Directory',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Icon(
                Icons.chevron_right_rounded,
                size: 12,
                color: AppColors.muted,
              ),
            ),
            Flexible(
              child: Text(
                'Active Members',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          'Faculty & Staff',
          style: TextStyle(
            fontSize: 19,
            height: 1.1,
            fontWeight: FontWeight.w700,
            color: AppColors.navy,
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: 3),
        Text(
          'Manage teaching personnel, departmental assignments, and attendance logs.',
          style: TextStyle(
            fontSize: 10,
            height: 1.2,
            fontWeight: FontWeight.w500,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}

class _PageActionButton extends StatelessWidget {
  const _PageActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    this.primary = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );
    const textStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.w600);

    return SizedBox(
      height: 31,
      child: primary
          ? FilledButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 14),
              label: Text(label),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
                padding: const EdgeInsets.symmetric(horizontal: 11),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: shape,
                textStyle: textStyle,
              ),
            )
          : OutlinedButton.icon(
              onPressed: onPressed,
              icon: Icon(icon, size: 14),
              label: Text(label),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.navy,
                backgroundColor: AppColors.white,
                side: const BorderSide(color: AppColors.border),
                padding: const EdgeInsets.symmetric(horizontal: 11),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: shape,
                textStyle: textStyle,
              ),
            ),
    );
  }
}

class _FacultyTable extends StatelessWidget {
  const _FacultyTable({
    required this.members,
    required this.selectedIds,
    required this.allSelected,
    required this.someSelected,
    required this.onToggleAll,
    required this.onToggleMember,
  });

  final List<_StaffMember> members;
  final Set<String> selectedIds;
  final bool allSelected;
  final bool someSelected;
  final VoidCallback onToggleAll;
  final ValueChanged<String> onToggleMember;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        children: [
          _TableHeader(
            allSelected: allSelected,
            someSelected: someSelected,
            onToggleAll: onToggleAll,
          ),
          Expanded(
            child: members.isEmpty
                ? const _EmptyTable()
                : ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: members.length,
                    itemBuilder: (context, index) {
                      final member = members[index];

                      return _FacultyRow(
                        member: member,
                        selected: selectedIds.contains(member.employeeId),
                        onToggle: () => onToggleMember(member.employeeId),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({
    required this.allSelected,
    required this.someSelected,
    required this.onToggleAll,
  });

  final bool allSelected;
  final bool someSelected;
  final VoidCallback onToggleAll;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      decoration: const BoxDecoration(
        color: AppColors.canvas,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Center(
              child: _SelectionBox(
                selected: allSelected,
                indeterminate: someSelected && !allSelected,
                onTap: onToggleAll,
              ),
            ),
          ),
          const Expanded(flex: 30, child: _HeaderLabel('FACULTY MEMBER')),
          const Expanded(flex: 24, child: _HeaderLabel('DEPARTMENT & ROLE')),
          const Expanded(flex: 24, child: _HeaderLabel('CONTACT INFORMATION')),
          const SizedBox(width: 90, child: _HeaderLabel('STATUS')),
          const SizedBox(
            width: 54,
            child: Center(child: _HeaderLabel('ACTIONS')),
          ),
        ],
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: AppColors.muted,
            letterSpacing: 0.35,
          ),
        ),
      ),
    );
  }
}

class _FacultyRow extends StatelessWidget {
  const _FacultyRow({
    required this.member,
    required this.selected,
    required this.onToggle,
  });

  final _StaffMember member;
  final bool selected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 28,
            child: Center(
              child: _SelectionBox(selected: selected, onTap: onToggle),
            ),
          ),
          Expanded(flex: 30, child: _MemberCell(member: member)),
          Expanded(flex: 24, child: _DepartmentCell(member: member)),
          Expanded(flex: 24, child: _ContactCell(member: member)),
          SizedBox(
            width: 90,
            child: Align(
              alignment: Alignment.centerLeft,
              child: _StatusPill(status: member.status),
            ),
          ),
          SizedBox(
            width: 54,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: IconButton(
                    onPressed: () {},
                    tooltip: 'View profile',
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 14,
                      color: AppColors.muted,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints.tightFor(
                      width: 24,
                      height: 24,
                    ),
                    splashRadius: 14,
                  ),
                ),
                _RowMenuButton(memberName: member.name),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberCell extends StatelessWidget {
  const _MemberCell({required this.member});

  final _StaffMember member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Row(
        children: [
          _UserAvatar(
            size: 30,
            initials: member.initials,
            gradient: member.avatarGradient,
            statusColor: member.status == _StaffStatus.active
                ? AppColors.primary
                : AppColors.muted,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  member.employeeId,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DepartmentCell extends StatelessWidget {
  const _DepartmentCell({required this.member});

  final _StaffMember member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            member.department,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            member.role,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactCell extends StatelessWidget {
  const _ContactCell({required this.member});

  final _StaffMember member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            member.email,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
              color: AppColors.navy,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            member.phone,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 8.5,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.status});

  final _StaffStatus status;

  @override
  Widget build(BuildContext context) {
    final isActive = status == _StaffStatus.active;
    final foreground = isActive ? AppColors.primary : AppColors.muted;
    final background = isActive ? AppColors.primarySoft : AppColors.divider;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
              color: foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            isActive ? 'Active' : 'On Leave',
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.w600,
              color: foreground,
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectionBox extends StatelessWidget {
  const _SelectionBox({
    required this.selected,
    required this.onTap,
    this.indeterminate = false,
  });

  final bool selected;
  final bool indeterminate;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final highlighted = selected || indeterminate;

    return Semantics(
      checked: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(3),
        child: SizedBox(
          width: 18,
          height: 18,
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: highlighted ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(3),
                border: Border.all(
                  color: highlighted ? AppColors.primary : AppColors.border,
                ),
              ),
              child: selected
                  ? const Icon(
                      Icons.check_rounded,
                      size: 10,
                      color: AppColors.white,
                    )
                  : indeterminate
                  ? Center(
                      child: Container(
                        width: 7,
                        height: 1.5,
                        color: AppColors.white,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}

class _RowMenuButton extends StatelessWidget {
  const _RowMenuButton({required this.memberName});

  final String memberName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: PopupMenuButton<String>(
        tooltip: 'Actions for $memberName',
        padding: EdgeInsets.zero,
        iconSize: 14,
        position: PopupMenuPosition.under,
        icon: const Icon(Icons.more_vert_rounded, color: AppColors.muted),
        itemBuilder: (context) => const [
          PopupMenuItem<String>(
            value: 'view',
            height: 32,
            child: Text(
              'View profile',
              style: TextStyle(fontSize: 10.5, color: AppColors.navy),
            ),
          ),
          PopupMenuItem<String>(
            value: 'edit',
            height: 32,
            child: Text(
              'Edit details',
              style: TextStyle(fontSize: 10.5, color: AppColors.navy),
            ),
          ),
          PopupMenuItem<String>(
            value: 'deactivate',
            height: 32,
            child: Text(
              'Deactivate',
              style: TextStyle(fontSize: 10.5, color: AppColors.danger),
            ),
          ),
        ],
        onSelected: (_) {},
      ),
    );
  }
}

class _EmptyTable extends StatelessWidget {
  const _EmptyTable();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.manage_search_rounded, size: 28, color: AppColors.border),
          SizedBox(height: 8),
          Text(
            'No faculty members found',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Try adjusting your search or filters.',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _Pagination extends StatelessWidget {
  const _Pagination({
    required this.totalCount,
    required this.visibleCount,
    required this.currentPage,
    required this.onPageChanged,
  });

  final int totalCount;
  final int visibleCount;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 520;

        return SizedBox(
          height: 24,
          child: Row(
            children: [
              if (!compact) ...[
                const Text(
                  'Show rows per page:',
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(width: 6),
                const _RowsPerPageSelector(),
              ],
              const Spacer(),
              Text(
                '1 – $visibleCount of $totalCount',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(width: 8),
              _PaginationButton(
                icon: Icons.chevron_left_rounded,
                enabled: currentPage > 1,
                onPressed: () => onPageChanged(currentPage - 1),
              ),
              const SizedBox(width: 4),
              for (var page = 1; page <= 3; page++) ...[
                _PaginationButton(
                  label: '$page',
                  active: currentPage == page,
                  onPressed: () => onPageChanged(page),
                ),
                if (page < 3) const SizedBox(width: 4),
              ],
              const SizedBox(width: 4),
              _PaginationButton(
                icon: Icons.chevron_right_rounded,
                enabled: currentPage < 3,
                onPressed: () => onPageChanged(currentPage + 1),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RowsPerPageSelector extends StatelessWidget {
  const _RowsPerPageSelector();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.only(left: 6, right: 3),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: '10',
          isDense: true,
          borderRadius: BorderRadius.circular(5),
          dropdownColor: AppColors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 12,
            color: AppColors.muted,
          ),
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
          items: const [
            DropdownMenuItem<String>(value: '10', child: Text('10')),
            DropdownMenuItem<String>(value: '25', child: Text('25')),
            DropdownMenuItem<String>(value: '50', child: Text('50')),
          ],
          onChanged: (_) {},
        ),
      ),
    );
  }
}

class _PaginationButton extends StatelessWidget {
  const _PaginationButton({
    required this.onPressed,
    this.label,
    this.icon,
    this.active = false,
    this.enabled = true,
  });

  final VoidCallback onPressed;
  final String? label;
  final IconData? icon;
  final bool active;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final background = active ? AppColors.primary : AppColors.white;
    final foreground = active
        ? AppColors.white
        : enabled
        ? AppColors.navy
        : AppColors.muted.withValues(alpha: 0.45);

    return SizedBox(
      width: 24,
      height: 24,
      child: Material(
        color: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(
            color: active ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(4),
          child: Center(
            child: icon != null
                ? Icon(icon, size: 13, color: foreground)
                : Text(
                    label!,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: foreground,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
