import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/dependency_injection.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';
import 'delete_staff_dialog.dart';

enum _StaffRowAction { toggleStatus, delete }

class StaffActionsMenu extends ConsumerWidget {
  const StaffActionsMenu({super.key, required this.member});

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
      onSelected: (action) => _handleSelected(context, ref, action),
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

  Future<void> _handleSelected(
    BuildContext context,
    WidgetRef ref,
    _StaffRowAction action,
  ) {
    return switch (action) {
      _StaffRowAction.toggleStatus => _toggleStatus(context, ref),
      _StaffRowAction.delete => _deleteStaff(context, ref),
    };
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

    final confirmed = await showDeleteStaffDialog(
      context,
      staffName: member.name,
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
