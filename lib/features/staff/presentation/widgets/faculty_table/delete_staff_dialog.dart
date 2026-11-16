import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

Future<bool?> showDeleteStaffDialog(
  BuildContext context, {
  required String staffName,
}) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) => DeleteStaffDialog(staffName: staffName),
  );
}

class DeleteStaffDialog extends StatelessWidget {
  const DeleteStaffDialog({super.key, required this.staffName});

  final String staffName;

  void _handleCancel(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  void _handleConfirm(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete staff member?'),
      content: Text(
        '$staffName will be permanently removed. This action cannot be undone.',
      ),
      actions: [
        TextButton(
          onPressed: () => _handleCancel(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => _handleConfirm(context),
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.danger,
            foregroundColor: AppColors.white,
          ),
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
