import 'package:flutter/material.dart';

class AppTheme {
  static const Color seedPurple = Color(0xFF6B66FF);
  static const Color primaryPurple = Color(0xFF7B61FF);

  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: seedPurple,
      primary: primaryPurple,
      secondary: Colors.deepPurpleAccent,
    ),
    useMaterial3: true,
  );
}
