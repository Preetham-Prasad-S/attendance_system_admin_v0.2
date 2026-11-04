import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

InputDecoration addFacultyFieldDecoration({
  String? hintText,
  IconData? icon,
  bool readOnly = false,
}) {
  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(6),
    borderSide: const BorderSide(color: AppColors.border),
  );

  return InputDecoration(
    hintText: hintText,
    hintStyle: const TextStyle(
      fontSize: 11.5,
      fontWeight: FontWeight.w500,
      color: AppColors.muted,
    ),
    prefixIcon: icon == null
        ? null
        : Icon(icon, size: 15, color: AppColors.muted),
    prefixIconConstraints: const BoxConstraints(minWidth: 32, minHeight: 32),
    contentPadding: EdgeInsets.fromLTRB(icon == null ? 12 : 2, 11, 10, 11),
    filled: true,
    fillColor: readOnly ? AppColors.canvas : AppColors.white,
    isDense: true,
    border: border,
    enabledBorder: border,
    focusedBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
    ),
    errorBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.danger),
    ),
    focusedErrorBorder: border.copyWith(
      borderSide: const BorderSide(color: AppColors.danger, width: 1.2),
    ),
    errorStyle: const TextStyle(
      fontSize: 9.5,
      height: 1.2,
      fontWeight: FontWeight.w500,
      color: AppColors.danger,
    ),
    errorMaxLines: 2,
  );
}
