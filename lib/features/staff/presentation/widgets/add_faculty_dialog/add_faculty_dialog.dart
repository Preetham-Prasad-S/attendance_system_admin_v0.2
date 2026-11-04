import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'add_faculty_dialog_header.dart';
import 'add_faculty_dialog_transition.dart';
import 'add_faculty_form.dart';

Future<void> showAddFacultyDialog(BuildContext context) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss add faculty dialog',
    barrierColor: AppColors.navy.withValues(alpha: 0.22),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return const AddFacultyDialog();
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return AddFacultyDialogTransition(animation: animation, child: child);
    },
  );
}

class AddFacultyDialog extends StatelessWidget {
  const AddFacultyDialog({super.key});

  void _handleDismiss(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: AppColors.navy.withValues(alpha: 0.14),
            blurRadius: 36,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Material(
        color: AppColors.transperant,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AddFacultyDialogHeader(onClose: () => _handleDismiss(context)),
            const Divider(height: 1, thickness: 1, color: AppColors.divider),
            Flexible(
              child: AddFacultyForm(onDismiss: () => _handleDismiss(context)),
            ),
          ],
        ),
      ),
    );
  }
}
