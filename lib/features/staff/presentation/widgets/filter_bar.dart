import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class FilterBar extends StatefulWidget {
  const FilterBar({
    super.key,
    required this.searchQuery,
    required this.department,
    required this.status,
    required this.departmentOptions,
    required this.statusOptions,
    this.onSearchChanged,
    this.onDepartmentChanged,
    this.onStatusChanged,
    this.totalRecords,
  });

  final String searchQuery;
  final String department;
  final String status;
  final List<String> departmentOptions;
  final List<String> statusOptions;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<String>? onDepartmentChanged;
  final ValueChanged<String>? onStatusChanged;
  final int? totalRecords;

  @override
  State<FilterBar> createState() => _FilterBarState();
}

class _FilterBarState extends State<FilterBar> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
    _searchController.addListener(_handleSearchTextChanged);
  }

  @override
  void didUpdateWidget(covariant FilterBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.searchQuery != _searchController.text) {
      _searchController.value = TextEditingValue(
        text: widget.searchQuery,
        selection: TextSelection.collapsed(offset: widget.searchQuery.length),
      );
    }
  }

  void _handleSearchTextChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.removeListener(_handleSearchTextChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _handleDepartmentSelected(String value) {
    widget.onDepartmentChanged?.call(value);
  }

  void _handleStatusSelected(String value) {
    widget.onStatusChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final totalRecords = widget.totalRecords ?? 0;

    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 600;

        if (compact) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SearchField(
                controller: _searchController,
                onChanged: widget.onSearchChanged,
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _FilterDropdown(
                      label: widget.department,
                      options: widget.departmentOptions,
                      onSelected: _handleDepartmentSelected,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _FilterDropdown(
                      label: widget.status,
                      options: widget.statusOptions,
                      onSelected: _handleStatusSelected,
                    ),
                  ),
                ],
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: _SearchField(
                controller: _searchController,
                onChanged: widget.onSearchChanged,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 160,
              child: _FilterDropdown(
                label: widget.department,
                options: widget.departmentOptions,
                onSelected: _handleDepartmentSelected,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 104,
              child: _FilterDropdown(
                label: widget.status,
                options: widget.statusOptions,
                onSelected: _handleStatusSelected,
              ),
            ),
            const SizedBox(width: 10),
            _TotalRecords(count: totalRecords),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({required this.controller, this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.navy,
      ),
      decoration: InputDecoration(
        hintText: 'Search faculty by name, ID, or email...',
        hintStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.muted,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          size: 18,
          color: AppColors.muted,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                onPressed: () {
                  controller.clear();
                  onChanged?.call('');
                },
                icon: const Icon(
                  Icons.close_rounded,
                  size: 16,
                  color: AppColors.muted,
                ),
                splashRadius: 18,
              )
            : null,
        suffixIconConstraints: const BoxConstraints(
          minWidth: 44,
          minHeight: 44,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 13,
          vertical: 13,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({
    required this.label,
    required this.options,
    required this.onSelected,
  });

  final String label;
  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      tooltip: '',
      offset: const Offset(0, 44),
      color: AppColors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      itemBuilder: (context) => [
        for (final option in options)
          PopupMenuItem<String>(
            value: option,
            height: 36,
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  child: option == label
                      ? const Icon(
                          Icons.check_rounded,
                          size: 15,
                          color: AppColors.primary,
                        )
                      : null,
                ),
                Expanded(
                  child: Text(
                    option,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: option == label
                          ? FontWeight.w700
                          : FontWeight.w500,
                      color: option == label
                          ? AppColors.primary
                          : AppColors.navy,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.navy,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 18,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}

class _TotalRecords extends StatelessWidget {
  const _TotalRecords({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.center,
      child: Text(
        'Total Records: $count',
        style: const TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: AppColors.muted,
        ),
      ),
    );
  }
}
