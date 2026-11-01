import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
      scaffoldBackgroundColor: AppColors.canvas,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.quicksandTextTheme(baseTheme.textTheme),
    );
  }
}
