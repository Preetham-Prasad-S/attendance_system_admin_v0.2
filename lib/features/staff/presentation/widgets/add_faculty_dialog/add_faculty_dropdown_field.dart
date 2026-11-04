import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'add_faculty_field_decoration.dart';

class AddFacultyDropdownField extends StatelessWidget {
  const AddFacultyDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium;

    return DropdownButtonFormField<String>(
      initialValue: value,
      isExpanded: true,
      isDense: true,
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        size: 18,
        color: AppColors.muted,
      ),
      dropdownColor: AppColors.white,
      borderRadius: BorderRadius.circular(8),
      menuMaxHeight: 280,
      style: textStyle?.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.navy,
      ),
      decoration: addFacultyFieldDecoration(),
      items: [
        for (final item in items)
          DropdownMenuItem<String>(
            value: item,
            child: Text(item, maxLines: 1, overflow: TextOverflow.ellipsis),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
