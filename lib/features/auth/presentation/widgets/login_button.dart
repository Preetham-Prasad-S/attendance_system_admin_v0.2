import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.onPressed,
    required this.isLoading,
    this.label = 'Sign In',
    this.icon = Icons.login_rounded,
    this.outlined = false,
  });

  final VoidCallback onPressed;
  final bool isLoading;
  final String label;
  final IconData icon;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final spinnerColor = outlined ? AppColors.primary : AppColors.white;

    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: outlined ? AppColors.white : AppColors.primary,
          foregroundColor: outlined ? AppColors.primary : AppColors.white,
          elevation: 0,
          shadowColor: AppColors.transperant,
          side: outlined
              ? const BorderSide(color: AppColors.primary)
              : BorderSide.none,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: spinnerColor,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
