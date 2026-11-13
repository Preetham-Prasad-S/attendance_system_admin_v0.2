import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/add_faculty_dialog/add_faculty_dialog.dart';
import '../widgets/faculty_table.dart';
import '../widgets/filter_bar.dart';
import '../widgets/page_header.dart';

class StaffScreen extends StatefulWidget {
  const StaffScreen({super.key});

  @override
  State<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends State<StaffScreen> {
  String _searchQuery = '';

  void _handleAddFaculty(BuildContext context) {
    showAddFacultyDialog(context);
  }

  void _handleSearchChanged(String query) {
    setState(() => _searchQuery = query.toLowerCase());
  }

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
            children: [
              PageHeader(onAddFaculty: () => _handleAddFaculty(context)),
              const SizedBox(height: 22),
              FilterBar(onSearchChanged: _handleSearchChanged),
              const SizedBox(height: 18),
              FacultyTable(searchQuery: _searchQuery),
            ],
          ),
        ),
      ),
    );
  }
}
