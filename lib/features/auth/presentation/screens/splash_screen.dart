import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const footerStyle = TextStyle(fontSize: 11.5, color: AppColors.muted);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
          child: Column(
            children: [
              const Row(
                children: [
                  SizedBox(
                    width: 7,
                    height: 7,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(width: 9),
                  Text(
                    'CAMPUSPULSE',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.6,
                      color: AppColors.brand,
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Institutional Portal',
                    style: TextStyle(fontSize: 11.5, color: AppColors.muted),
                  ),
                ],
              ),
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 96,
                          height: 96,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 24,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.school_rounded,
                            color: AppColors.white,
                            size: 44,
                          ),
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'CampusPulse',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                            color: AppColors.navy,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'SMART ATTENDANCE OS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.muted,
                            letterSpacing: 2.2,
                          ),
                        ),
                        const SizedBox(height: 44),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Loading portal...',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.navy,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Connecting to institutional attendance services',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 20,
                runSpacing: 8,
                children: const [
                  Text(
                    '© 2025 CampusPulse Academic Technologies · '
                    'St. Augustine Engineering & Tech Campus',
                    style: footerStyle,
                  ),
                  Wrap(
                    spacing: 16,
                    children: [
                      Text('Privacy Policy', style: footerStyle),
                      Text('Terms of Service', style: footerStyle),
                      Text('Helpdesk', style: footerStyle),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
