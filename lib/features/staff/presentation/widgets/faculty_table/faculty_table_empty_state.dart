import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class FacultyTableEmptyState extends StatelessWidget {
  const FacultyTableEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      alignment: Alignment.center,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_rounded, size: 32, color: AppColors.muted),
          SizedBox(height: 10),
          Text(
            'No faculty found',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.navy,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Try adjusting your search or filters',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.muted,
            ),
          ),
        ],
      ),
    );
  }
}
