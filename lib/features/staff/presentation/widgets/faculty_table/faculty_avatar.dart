import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class FacultyAvatar extends StatelessWidget {
  const FacultyAvatar({
    super.key,
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
