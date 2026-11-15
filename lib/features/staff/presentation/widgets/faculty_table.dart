import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/dependency_injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entity/staff_entity.dart';
import '../controller/staff_state.dart';

const _avatarPalette = <Color>[
  AppColors.avatarBlue,
  AppColors.avatarViolet,
  AppColors.avatarEmerald,
  AppColors.avatarOrange,
  AppColors.avatarPink,
];

enum _StaffRowAction { toggleStatus, delete }

String _initialsFor(String name) {
  final parts = name
      .replaceAll('.', '')
      .split(' ')
      .where((part) => part != 'Dr' && part != 'Prof' && part.isNotEmpty)
      .take(2);

  return parts.map((part) => part[0]).join().toUpperCase();
}

class FacultyTable extends StatefulWidget {
  const FacultyTable({super.key, required this.members});

  final List<StaffEntity> members;

  @override
  State<FacultyTable> createState() => _FacultyTableState();
}

class _FacultyTableState extends State<FacultyTable> {
  static const _rowsPerPageOptions = <int>[5, 10, 25, 50];

  static const _maxVisiblePages = 3;

  int _rowsPerPage = 10;
  int _currentPage = 1;

  int get _totalPages => _totalPagesFor(widget.members.length);

  int _totalPagesFor(int recordCount) {
    if (recordCount == 0) return 1;
    return (recordCount + _rowsPerPage - 1) ~/ _rowsPerPage;
  }

  @override
  void didUpdateWidget(covariant FacultyTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.members.length != widget.members.length) {
      final totalPages = _totalPagesFor(widget.members.length);
      if (_currentPage > totalPages) {
        _currentPage = totalPages;
      }
    }
  }

  void _handleRowsPerPageChanged(int rowsPerPage) {
    setState(() {
      _rowsPerPage = rowsPerPage;
      _currentPage = 1;
    });
  }

  void _handlePageChanged(int page) {
    final totalPages = _totalPages;

    if (page < 1 || page > totalPages || page == _currentPage) {
      return;
    }

    setState(() => _currentPage = page);
  }

  List<int> _visiblePages() {
    final totalPages = _totalPages;

    if (totalPages <= _maxVisiblePages) {
      return [for (var page = 1; page <= totalPages; page++) page];
    }

    var firstPage = _currentPage - 1;
    if (firstPage < 1) firstPage = 1;
    if (firstPage + _maxVisiblePages - 1 > totalPages) {
      firstPage = totalPages - _maxVisiblePages + 1;
    }

    return [
      for (var page = firstPage; page < firstPage + _maxVisiblePages; page++)
        page,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final pageMembers = widget.members
        .skip(startIndex)
        .take(_rowsPerPage)
        .toList();

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
                for (var index = 0; index < pageMembers.length; index++) ...[
                  _FacultyRow(
                    member: pageMembers[index],
                    showContact: showContact,
                    showStatus: showStatus,
                  ),
                  if (index < pageMembers.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.divider,
                    ),
                ],
                if (widget.members.isEmpty) const _EmptySearchResult(),
                _TablePagination(
                  totalRecords: widget.members.length,
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  visiblePages: _visiblePages(),
                  rowsPerPage: _rowsPerPage,
                  rowsPerPageOptions: _rowsPerPageOptions,
                  onRowsPerPageChanged: _handleRowsPerPageChanged,
                  onPageChanged: _handlePageChanged,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EmptySearchResult extends StatelessWidget {
  const _EmptySearchResult();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 32, color: AppColors.muted),
          SizedBox(height: 10),
          Text(
            'No faculty found',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
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

  final StaffEntity member;
  final bool showContact;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    final isActive = member.status;

    return SizedBox(
      height: 66,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
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
                    label: isActive ? activeStatusLabel : inactiveStatusLabel,
                    active: isActive,
                  ),
                ),
              ),
            ],
            SizedBox(
              width: 36,
              height: 36,
              child: _StaffActionsMenu(member: member),
            ),
          ],
        ),
      ),
    );
  }
}

class _StaffActionsMenu extends ConsumerWidget {
  const _StaffActionsMenu({required this.member});

  final StaffEntity member;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<_StaffRowAction>(
      tooltip: 'Staff actions',
      padding: EdgeInsets.zero,
      icon: const Icon(Icons.more_vert_rounded),
      iconSize: 18,
      iconColor: AppColors.muted,
      color: AppColors.white,
      surfaceTintColor: Colors.transparent,
      constraints: const BoxConstraints(minWidth: 190),
      onSelected: (action) async {
        switch (action) {
          case _StaffRowAction.toggleStatus:
            await _toggleStatus(context, ref);
          case _StaffRowAction.delete:
            await _deleteStaff(context, ref);
        }
      },
      itemBuilder: (context) => [
        PopupMenuItem<_StaffRowAction>(
          value: _StaffRowAction.toggleStatus,
          height: 38,
          child: const _StaffMenuItem(
            icon: Icons.swap_horiz_rounded,
            label: 'Change status',
          ),
        ),
        const PopupMenuDivider(height: 1),
        const PopupMenuItem<_StaffRowAction>(
          value: _StaffRowAction.delete,
          height: 38,
          child: _StaffMenuItem(
            icon: Icons.delete_outline_rounded,
            label: 'Delete staff member',
            danger: true,
          ),
        ),
      ],
    );
  }

  Future<void> _toggleStatus(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final nextStatus = !member.status;

    final failure = await ref
        .read(staffControllerProvider.notifier)
        .setStaffStatus(member, status: nextStatus);

    if (failure != null) {
      _showMessage(messenger, failure.toString(), isError: true);
      return;
    }

    _showMessage(
      messenger,
      nextStatus
          ? 'Staff member marked active.'
          : 'Staff member marked inactive.',
    );
  }

  Future<void> _deleteStaff(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete staff member?'),
          content: Text(
            '${member.name} will be permanently removed. This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: AppColors.white,
              ),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    final failure = await ref
        .read(staffControllerProvider.notifier)
        .deleteStaff(member);

    if (failure != null) {
      _showMessage(messenger, failure.toString(), isError: true);
      return;
    }

    _showMessage(messenger, 'Staff member deleted.');
  }

  void _showMessage(
    ScaffoldMessengerState messenger,
    String message, {
    bool isError = false,
  }) {
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? AppColors.danger : AppColors.navy,
        ),
      );
  }
}

class _StaffMenuItem extends StatelessWidget {
  const _StaffMenuItem({
    required this.icon,
    required this.label,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final color = danger ? AppColors.danger : AppColors.navy;

    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 9),
        Text(
          label,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _MemberCell extends StatelessWidget {
  const _MemberCell({required this.member});

  final StaffEntity member;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _UserAvatar(
          label: _initialsFor(member.name),
          color: _avatarPalette[member.id.hashCode % _avatarPalette.length],
          statusColor: member.status ? AppColors.success : AppColors.muted,
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
                member.staffId,
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

  final StaffEntity member;

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
            fontSize: 12.5,
            fontWeight: FontWeight.w600,
            color: AppColors.navy,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          member.position,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
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

  final StaffEntity member;

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
          text: member.phoneNo?.toString() ?? '—',
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
              fontSize: 11.5,
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
    final foreground = active ? AppColors.success : AppColors.muted;
    final background = active ? AppColors.successSoft : AppColors.canvas;

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
  const _TablePagination({
    required this.totalRecords,
    required this.currentPage,
    required this.totalPages,
    required this.visiblePages,
    required this.rowsPerPage,
    required this.rowsPerPageOptions,
    required this.onRowsPerPageChanged,
    required this.onPageChanged,
  });

  final int totalRecords;
  final int currentPage;
  final int totalPages;
  final List<int> visiblePages;
  final int rowsPerPage;
  final List<int> rowsPerPageOptions;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<int> onPageChanged;

  String get _rangeLabel {
    if (totalRecords == 0) return '0 of 0';

    final firstRow = (currentPage - 1) * rowsPerPage + 1;
    final lastRow = (currentPage * rowsPerPage).clamp(0, totalRecords);

    return '$firstRow – $lastRow of $totalRecords';
  }

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
                _RowsPerPage(
                  value: rowsPerPage,
                  options: rowsPerPageOptions,
                  onChanged: onRowsPerPageChanged,
                ),
              ],
              const Spacer(),
              Text(
                _rangeLabel,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(width: 12),
              _PageButton(
                icon: Icons.chevron_left_rounded,
                onPressed: currentPage > 1
                    ? () => onPageChanged(currentPage - 1)
                    : null,
              ),
              for (final page in visiblePages) ...[
                const SizedBox(width: 5),
                _PageButton(
                  label: '$page',
                  active: page == currentPage,
                  onPressed: () => onPageChanged(page),
                ),
              ],
              const SizedBox(width: 5),
              _PageButton(
                icon: Icons.chevron_right_rounded,
                onPressed: currentPage < totalPages
                    ? () => onPageChanged(currentPage + 1)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RowsPerPage extends StatelessWidget {
  const _RowsPerPage({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final int value;
  final List<int> options;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: onChanged,
      tooltip: '',
      padding: EdgeInsets.zero,
      offset: const Offset(0, 26),
      color: AppColors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      itemBuilder: (context) => [
        for (final option in options)
          PopupMenuItem<int>(
            value: option,
            height: 32,
            child: Text(
              '$option',
              style: TextStyle(
                fontSize: 11,
                fontWeight: option == value ? FontWeight.w700 : FontWeight.w500,
                color: option == value ? AppColors.primary : AppColors.navy,
              ),
            ),
          ),
      ],
      child: Container(
        height: 26,
        padding: const EdgeInsets.only(left: 7, right: 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 12,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageButton extends StatelessWidget {
  const _PageButton({
    this.label,
    this.icon,
    this.active = false,
    this.onPressed,
  });

  final String? label;
  final IconData? icon;
  final bool active;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    final foreground = active
        ? AppColors.white
        : enabled
        ? AppColors.navy
        : AppColors.muted;

    return MouseRegion(
      cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: Material(
        color: AppColors.transperant,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(4),
          hoverColor: AppColors.primarySoft,
          splashColor: AppColors.primarySoft,
          child: Ink(
            width: 26,
            height: 26,
            decoration: BoxDecoration(
              color: active ? AppColors.primary : AppColors.white,
              border: Border.all(
                color: active ? AppColors.primary : AppColors.divider,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
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
            ),
          ),
        ),
      ),
    );
  }
}
