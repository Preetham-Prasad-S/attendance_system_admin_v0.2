import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class AddFacultyField extends StatelessWidget {
  const AddFacultyField({
    super.key,
    required this.label,
    required this.child,
    this.isRequired = false,
    this.trailing,
  });

  final String label;
  final Widget child;
  final bool isRequired;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Flexible(
              child: Text.rich(
                TextSpan(
                  text: label.toUpperCase(),
                  children: [
                    if (isRequired)
                      const TextSpan(
                        text: ' *',
                        style: TextStyle(color: AppColors.navy),
                      ),
                  ],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 9.5,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.45,
                  color: AppColors.navy,
                ),
              ),
            ),
            if (trailing != null) ...[const Spacer(), trailing!],
          ],
        ),
        const SizedBox(height: 7),
        child,
      ],
    );
  }
}
