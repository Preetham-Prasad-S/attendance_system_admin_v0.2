import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../auth/domain/entity/user_authorization_entity.dart';

class FacultyAuthorizationTag extends StatelessWidget {
  const FacultyAuthorizationTag({super.key, required this.authorityLevel});

  final String? authorityLevel;

  @override
  Widget build(BuildContext context) {
    final level = authorityLevel?.trim().toLowerCase();
    final isAdmin = level != null && adminAuthorityLevels.contains(level);
    final isUnassigned = level == null || level.isEmpty;

    late final Color foreground;
    late final Color background;
    late final IconData icon;

    if (isAdmin) {
      foreground = AppColors.brand;
      background = AppColors.primarySoft;
      icon = Icons.shield_outlined;
    } else if (isUnassigned) {
      foreground = AppColors.muted;
      background = AppColors.canvas;
      icon = Icons.remove_circle_outline_rounded;
    } else {
      foreground = AppColors.mutedStrong;
      background = AppColors.canvas;
      icon = Icons.badge_outlined;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: foreground),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              _labelFor(level),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
                color: foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _labelFor(String? level) {
    if (level == null || level.isEmpty) return 'Unassigned';

    return switch (level) {
      'super' => 'Super Admin',
      'admin' => 'Admin',
      'staff' => 'Staff',
      _ => '${level[0].toUpperCase()}${level.substring(1)}',
    };
  }
}
