import 'package:flutter/material.dart';
import 'package:weather_app/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightModeTheme =>
      ThemeData(brightness: .light, scaffoldBackgroundColor: Color(0xFF5694d2),
      appBarTheme: AppBarTheme(backgroundColor: Color(0xFF5694d2),));
  static ThemeData get darkModeTheme => ThemeData(
    brightness: .dark,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.nightColor),
    scaffoldBackgroundColor: AppColors.nightColor,
  );
}
