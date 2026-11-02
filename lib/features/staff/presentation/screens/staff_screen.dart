import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/faculty_table.dart';
import '../widgets/filter_bar.dart';
import '../widgets/page_header.dart';

class StaffScreen extends StatelessWidget {
  const StaffScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 24,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              PageHeader(),
              SizedBox(height: 22),
              FilterBar(),
              SizedBox(height: 18),
              FacultyTable(),
            ],
          ),
        ),
      ),
    );
  }
}
