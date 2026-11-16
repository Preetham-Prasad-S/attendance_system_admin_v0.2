import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';

class FacultyContactCell extends StatelessWidget {
  const FacultyContactCell({super.key, required this.member});

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
