import 'package:flutter/material.dart';

import '../../../../core/app_colors.dart';
import '../widgets/login_card.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const footerStyle = TextStyle(fontSize: 13.5, color: AppColors.muted);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 48, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 512),
            child: Column(
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: AppColors.white,
                          size: 33,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Text(
                        'CampusPresence',
                        style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w800,
                          color: AppColors.brand,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 76),
                const LoginCard(),
                const SizedBox(height: 32),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Need assistance? ',
                        style: TextStyle(
                          fontSize: 13.5,
                          color: AppColors.muted,
                        ),
                      ),
                      TextSpan(
                        text: 'Contact Campus IT Helpdesk',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 64),
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 24,
                  runSpacing: 10,
                  children: const [
                    Text('© 2025 CampusPresence', style: footerStyle),
                    Wrap(
                      spacing: 20,
                      children: [
                        Text('Terms', style: footerStyle),
                        Text('Privacy', style: footerStyle),
                        Text('Helpdesk', style: footerStyle),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
