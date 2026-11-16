import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';

class FacultyDepartmentCell extends StatelessWidget {
  const FacultyDepartmentCell({super.key, required this.member});

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
