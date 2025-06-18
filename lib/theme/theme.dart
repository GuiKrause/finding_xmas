import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 255, 255, 255);
  static const Color secondary = Color(0xFFEF6C00);
  static const Color tertiary = Colors.black12;
  static const Color quaternary = Color(0xFF757575); // Colors.grey.shade600
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSwatch(
    accentColor: AppColors.secondary,
    backgroundColor: AppColors.primary,
  ),
  scaffoldBackgroundColor: AppColors.primary,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      foregroundColor: AppColors.primary,
    ),
  ),
);
