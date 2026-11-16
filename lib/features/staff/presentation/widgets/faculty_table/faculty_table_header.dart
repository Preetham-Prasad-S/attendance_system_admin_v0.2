import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class FacultyTableHeader extends StatelessWidget {
  const FacultyTableHeader({
    super.key,
    required this.showContact,
    required this.showStatus,
  });

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
