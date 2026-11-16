import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class FacultyStatusPill extends StatelessWidget {
  const FacultyStatusPill({
    super.key,
    required this.label,
    required this.active,
  });

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
