import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class FacultyRowsPerPage extends StatelessWidget {
  const FacultyRowsPerPage({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  final int value;
  final List<int> options;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      onSelected: onChanged,
      tooltip: '',
      padding: EdgeInsets.zero,
      offset: const Offset(0, 26),
      color: AppColors.white,
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      itemBuilder: (context) => [
        for (final option in options)
          PopupMenuItem<int>(
            value: option,
            height: 32,
            child: Text(
              '$option',
              style: TextStyle(
                fontSize: 11,
                fontWeight: option == value ? FontWeight.w700 : FontWeight.w500,
                color: option == value ? AppColors.primary : AppColors.navy,
              ),
            ),
          ),
      ],
      child: Container(
        height: 26,
        padding: const EdgeInsets.only(left: 7, right: 4),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.navy,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 12,
              color: AppColors.muted,
            ),
          ],
        ),
      ),
    );
  }
}
