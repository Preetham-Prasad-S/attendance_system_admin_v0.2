import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'faculty_page_button.dart';
import 'faculty_rows_per_page.dart';

class FacultyTablePagination extends StatelessWidget {
  const FacultyTablePagination({
    super.key,
    required this.totalRecords,
    required this.currentPage,
    required this.totalPages,
    required this.visiblePages,
    required this.rowsPerPage,
    required this.rowsPerPageOptions,
    required this.onRowsPerPageChanged,
    required this.onPageChanged,
  });

  final int totalRecords;
  final int currentPage;
  final int totalPages;
  final List<int> visiblePages;
  final int rowsPerPage;
  final List<int> rowsPerPageOptions;
  final ValueChanged<int> onRowsPerPageChanged;
  final ValueChanged<int> onPageChanged;

  String get _rangeLabel {
    if (totalRecords == 0) return '0 of 0';

    final firstRow = (currentPage - 1) * rowsPerPage + 1;
    final lastRow = (currentPage * rowsPerPage).clamp(0, totalRecords);

    return '$firstRow – $lastRow of $totalRecords';
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: AppColors.divider)),
          ),
          child: Row(
            children: [
              if (constraints.maxWidth >= 520) ...[
                const Text(
                  'Show rows per page:',
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w500,
                    color: AppColors.muted,
                  ),
                ),
                const SizedBox(width: 10),
                FacultyRowsPerPage(
                  value: rowsPerPage,
                  options: rowsPerPageOptions,
                  onChanged: onRowsPerPageChanged,
                ),
              ],
              const Spacer(),
              Text(
                _rangeLabel,
                style: const TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w500,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(width: 12),
              FacultyPageButton(
                icon: Icons.chevron_left_rounded,
                onPressed: currentPage > 1
                    ? () => onPageChanged(currentPage - 1)
                    : null,
              ),
              for (final page in visiblePages) ...[
                const SizedBox(width: 5),
                FacultyPageButton(
                  label: '$page',
                  active: page == currentPage,
                  onPressed: () => onPageChanged(page),
                ),
              ],
              const SizedBox(width: 5),
              FacultyPageButton(
                icon: Icons.chevron_right_rounded,
                onPressed: currentPage < totalPages
                    ? () => onPageChanged(currentPage + 1)
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}
