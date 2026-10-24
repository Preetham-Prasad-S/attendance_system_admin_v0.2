import 'package:flutter/material.dart';

import 'core/app_theme.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance System Admin',
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
