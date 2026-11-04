import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import 'add_faculty_field_decoration.dart';

class AddFacultyTextField extends StatelessWidget {
  const AddFacultyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final FormFieldValidator<String>? validator;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      validator: validator,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.navy,
      ),
      cursorColor: AppColors.primary,
      decoration: addFacultyFieldDecoration(
        hintText: hintText,
        icon: icon,
        readOnly: readOnly,
      ),
    );
  }
}
