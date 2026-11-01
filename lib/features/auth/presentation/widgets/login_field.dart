import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.autofillHints,
    this.textInputAction,
    this.validator,
    this.suffix,
  });

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Iterable<String>? autofillHints;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    const baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
      borderSide: BorderSide(color: AppColors.border),
    );

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      autofillHints: autofillHints,
      textInputAction: textInputAction,
      validator: validator,
      style: const TextStyle(fontSize: 15, color: AppColors.navy),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 14.5, color: AppColors.muted),
        prefixIcon: Icon(icon, size: 20, color: AppColors.muted),
        suffixIcon: suffix,
        suffixIconConstraints: const BoxConstraints(minWidth: 44),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        filled: true,
        fillColor: AppColors.white,
        isDense: true,
        border: baseBorder,
        enabledBorder: baseBorder,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          borderSide: BorderSide(color: AppColors.primary, width: 1.4),
        ),
      ),
    );
  }
}
