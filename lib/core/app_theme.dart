import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.openSansTextTheme(baseTheme.textTheme),
    );
  }
}
