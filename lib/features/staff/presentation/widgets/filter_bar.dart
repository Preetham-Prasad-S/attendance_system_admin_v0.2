import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 600;

        if (compact) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _SearchField(),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _FilterDropdown(label: 'Computer Science & Eng'),
                  ),
                  SizedBox(width: 10),
                  Expanded(child: _FilterDropdown(label: 'All Statuses')),
                ],
              ),
            ],
          );
        }

        return const Row(
          children: [
            Expanded(child: _SearchField()),
            SizedBox(width: 10),
            SizedBox(
              width: 160,
              child: _FilterDropdown(label: 'Computer Science & Eng'),
            ),
            SizedBox(width: 10),
            SizedBox(width: 104, child: _FilterDropdown(label: 'All Statuses')),
            SizedBox(width: 10),
            _TotalRecords(),
          ],
        );
      },
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 13),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(7),
      ),
      child: const Row(
        children: [
          Icon(Icons.search_rounded, size: 18, color: AppColors.muted),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'Search faculty by name, ID, or email...',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  const _FilterDropdown({required this.label});

  final String label;

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
    );
  }
}

class _TotalRecords extends StatelessWidget {
  const _TotalRecords();

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
      child: const Text(
        'Total Records: 48',
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w600,
          color: AppColors.muted,
        ),
      ),
    );
  }
}
