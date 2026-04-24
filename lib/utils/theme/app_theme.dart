import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightModeTheme =>
      ThemeData(brightness: .light, scaffoldBackgroundColor: Color(0xFF5694d2),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF5694d2),));
  static ThemeData get darkModeTheme => ThemeData(
    brightness: .dark,
    appBarTheme: AppBarTheme(backgroundColor: Color(0xFF050624)),
    scaffoldBackgroundColor: Color(0xFF050624),
  );
}
