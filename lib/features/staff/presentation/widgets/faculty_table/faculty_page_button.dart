import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class FacultyPageButton extends StatelessWidget {
  const FacultyPageButton({
    super.key,
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
