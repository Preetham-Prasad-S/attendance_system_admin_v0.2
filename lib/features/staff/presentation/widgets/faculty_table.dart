import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class FacultyTable extends StatelessWidget {
  const FacultyTable({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final showContact = constraints.maxWidth >= 640;
        final showStatus = constraints.maxWidth >= 450;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                _TableHeader(showContact: showContact, showStatus: showStatus),
                for (var index = 0; index < _members.length; index++) ...[
                  _FacultyRow(
                    member: _members[index],
                    showContact: showContact,
                    showStatus: showStatus,
                  ),
                  if (index < _members.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.divider,
                    ),
                ],
                const _TablePagination(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.showContact, required this.showStatus});

  final bool showContact;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: const BoxDecoration(
        color: AppColors.canvas,
        border: Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          const SizedBox(width: 30),
          const SizedBox(width: 14),
          const Expanded(flex: 3, child: _HeaderLabel('FACULTY MEMBER')),
          const SizedBox(width: 14),
          const Expanded(flex: 3, child: _HeaderLabel('DEPARTMENT & ROLE')),
          if (showContact) ...[
            const SizedBox(width: 14),
            const Expanded(flex: 3, child: _HeaderLabel('CONTACT INFORMATION')),
          ],
          if (showStatus) ...[
            const SizedBox(width: 14),
            const Expanded(flex: 2, child: _HeaderLabel('STATUS')),
          ],
          const SizedBox(width: 36),
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
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontSize: 10.5,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
        color: AppColors.muted,
      ),
    );
  }
}

class _FacultyRow extends StatelessWidget {
  const _FacultyRow({
    required this.member,
    required this.showContact,
    required this.showStatus,
  });

  final _StaffMember member;
  final bool showContact;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final isActive = member.status == _StaffStatus.active;

    return SizedBox(
      height: 66,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            const SizedBox(width: 30, child: _SelectionBox()),
            const SizedBox(width: 14),
            Expanded(flex: 3, child: _MemberCell(member: member)),
            const SizedBox(width: 14),
            Expanded(flex: 3, child: _DepartmentCell(member: member)),
            if (showContact) ...[
              const SizedBox(width: 14),
              Expanded(flex: 3, child: _ContactCell(member: member)),
            ],
            if (showStatus) ...[
              const SizedBox(width: 14),
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: _StatusPill(
                    label: isActive ? 'Active' : 'On Leave',
                    active: isActive,
                  ),
                ),
              ),
            ],
            const SizedBox(
              width: 36,
              child: Icon(
                Icons.more_vert_rounded,
                size: 18,
                color: AppColors.muted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberCell extends StatelessWidget {
  const _MemberCell({required this.member});

  final _StaffMember member;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _UserAvatar(
          label: member.initials,
          color: member.avatarColor,
          statusColor: member.status == _StaffStatus.active
              ? AppColors.success
              : AppColors.warning,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.navy,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                member.employeeId,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DepartmentCell extends StatelessWidget {
  const _DepartmentCell({required this.member});

  final _StaffMember member;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          member.department,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          member.role,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }
}

class _ContactCell extends StatelessWidget {
  const _ContactCell({required this.member});

  final _StaffMember member;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ContactLine(
          icon: Icons.mail_outline_rounded,
          text: member.email,
          color: AppColors.navy,
        ),
        const SizedBox(height: 3),
        _ContactLine(
          icon: Icons.phone_outlined,
          text: member.phone,
          color: AppColors.muted,
        ),
      ],
    );
  }
}

class _ContactLine extends StatelessWidget {
  const _ContactLine({
    required this.icon,
    required this.text,
    required this.color,
  });

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 11, color: AppColors.muted),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final foreground = active ? AppColors.success : AppColors.warning;
    final background = active ? AppColors.successSoft : AppColors.warningSoft;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: foreground,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            label,
            maxLines: 1,
            style: TextStyle(
              fontSize: 10.5,
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
  const _SelectionBox();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}

class _UserAvatar extends StatelessWidget {
  const _UserAvatar({
    required this.label,
    required this.color,
    required this.statusColor,
  });

  final String label;
  final Color color;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: AppColors.white,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 1.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TablePagination extends StatelessWidget {
  const _TablePagination();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              if (constraints.maxWidth >= 520) ...[
                const Text(
                  'Show rows per page:',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(width: 10),
                const _RowsPerPage(),
              ],
              const Spacer(),
              const Text(
                '1 – 5 of 48',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(width: 12),
              const _PageButton(icon: Icons.chevron_left_rounded),
              const SizedBox(width: 5),
              const _PageButton(label: '1', active: true),
              const SizedBox(width: 5),
              const _PageButton(label: '2'),
              const SizedBox(width: 5),
              const _PageButton(label: '3'),
              const SizedBox(width: 5),
              const _PageButton(icon: Icons.chevron_right_rounded),
            ],
          ),
        );
      },
    );
  }
}

class _RowsPerPage extends StatelessWidget {
  const _RowsPerPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.only(left: 7, right: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.divider),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Row(
        children: [
          Text(
            '10',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          SizedBox(width: 4),
          Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 12,
            color: AppColors.muted,
          ),
        ],
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({this.label, this.icon, this.active = false});

  final String? label;
  final IconData? icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final foreground = active ? AppColors.white : AppColors.navy;

    return Container(
      width: 26,
      height: 26,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.white,
        border: Border.all(
          color: active ? AppColors.primary : AppColors.divider,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: icon != null
          ? Icon(icon, size: 13, color: foreground)
          : Text(
              label!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
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
    required this.avatarColor,
  });

  final String name;
  final String employeeId;
  final String department;
  final String role;
  final String email;
  final String phone;
  final _StaffStatus status;
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

const _members = <_StaffMember>[
  _StaffMember(
    name: 'Dr. Rajeshwari Sengupta',
    employeeId: 'EMP-CS-041',
    department: 'Computer Science & Eng',
    role: 'Professor & Head of Dept',
    email: 'r.sengupta@campus.edu',
    phone: '+1 (555) 234-8801',
    status: _StaffStatus.active,
    avatarColor: AppColors.avatarBlue,
  ),
  _StaffMember(
    name: 'Prof. Marcus Thorne',
    employeeId: 'EMP-CS-112',
    department: 'Computer Science & Eng',
    role: 'Associate Professor',
    email: 'm.thorne@campus.edu',
    phone: '+1 (555) 489-1029',
    status: _StaffStatus.active,
    avatarColor: AppColors.avatarViolet,
  ),
  _StaffMember(
    name: 'Dr. Elena Rostova',
    employeeId: 'EMP-CS-204',
    department: 'Computer Science & Eng',
    role: 'Assistant Professor',
    email: 'e.rostova@campus.edu',
    phone: '+1 (555) 762-3804',
    status: _StaffStatus.active,
    avatarColor: AppColors.avatarEmerald,
  ),
  _StaffMember(
    name: 'David K. Chen',
    employeeId: 'EMP-CS-155',
    department: 'Computer Science & Eng',
    role: 'Senior Lab Instructor',
    email: 'd.chen@campus.edu',
    phone: '+1 (555) 881-9923',
    status: _StaffStatus.onLeave,
    avatarColor: AppColors.avatarOrange,
  ),
  _StaffMember(
    name: 'Dr. Amara Okafor',
    employeeId: 'EMP-CS-068',
    department: 'Computer Science & Eng',
    role: 'Associate Professor',
    email: 'a.okafor@campus.edu',
    phone: '+1 (555) 672-9045',
    status: _StaffStatus.active,
    avatarColor: AppColors.avatarPink,
  ),
];
