import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entity/staff_entity.dart';
import 'faculty_table_empty_state.dart';
import 'faculty_table_header.dart';
import 'faculty_table_pagination.dart';
import 'faculty_table_row.dart';

class FacultyTable extends StatefulWidget {
  const FacultyTable({super.key, required this.members});

  final List<StaffEntity> members;

  @override
  State<FacultyTable> createState() => _FacultyTableState();
}

class _FacultyTableState extends State<FacultyTable> {
  static const _rowsPerPageOptions = <int>[5, 10, 25, 50];

  static const _maxVisiblePages = 3;

  int _rowsPerPage = 10;
  int _currentPage = 1;

  int get _totalPages => _totalPagesFor(widget.members.length);

  int _totalPagesFor(int recordCount) {
    if (recordCount == 0) return 1;
    return (recordCount + _rowsPerPage - 1) ~/ _rowsPerPage;
  }

  @override
  void didUpdateWidget(covariant FacultyTable oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.members.length != widget.members.length) {
      final totalPages = _totalPagesFor(widget.members.length);
      if (_currentPage > totalPages) {
        _currentPage = totalPages;
      }
    }
  }

  void _handleRowsPerPageChanged(int rowsPerPage) {
    setState(() {
      _rowsPerPage = rowsPerPage;
      _currentPage = 1;
    });
  }

  void _handlePageChanged(int page) {
    final totalPages = _totalPages;

    if (page < 1 || page > totalPages || page == _currentPage) {
      return;
    }

    setState(() => _currentPage = page);
  }

  List<int> _visiblePages() {
    final totalPages = _totalPages;

    if (totalPages <= _maxVisiblePages) {
      return [for (var page = 1; page <= totalPages; page++) page];
    }

    var firstPage = _currentPage - 1;
    if (firstPage < 1) firstPage = 1;
    if (firstPage + _maxVisiblePages - 1 > totalPages) {
      firstPage = totalPages - _maxVisiblePages + 1;
    }

    return [
      for (var page = firstPage; page < firstPage + _maxVisiblePages; page++)
        page,
    ];
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = (_currentPage - 1) * _rowsPerPage;
    final pageMembers = widget.members
        .skip(startIndex)
        .take(_rowsPerPage)
        .toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final showContact = constraints.maxWidth >= 640;
        final showStatus = constraints.maxWidth >= 450;

        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              children: [
                FacultyTableHeader(
                  showContact: showContact,
                  showStatus: showStatus,
                ),
                for (var index = 0; index < pageMembers.length; index++) ...[
                  FacultyTableRow(
                    member: pageMembers[index],
                    showContact: showContact,
                    showStatus: showStatus,
                  ),
                  if (index < pageMembers.length - 1)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.divider,
                    ),
                ],
                if (widget.members.isEmpty) const FacultyTableEmptyState(),
                FacultyTablePagination(
                  totalRecords: widget.members.length,
                  currentPage: _currentPage,
                  totalPages: _totalPages,
                  visiblePages: _visiblePages(),
                  rowsPerPage: _rowsPerPage,
                  rowsPerPageOptions: _rowsPerPageOptions,
                  onRowsPerPageChanged: _handleRowsPerPageChanged,
                  onPageChanged: _handlePageChanged,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
