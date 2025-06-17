import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color.fromARGB(255, 255, 255, 255);        // Azul forte
  static const Color secondary = Color(0xFFEF6C00);      // Laranja vibrante
  static const Color backgroundCell = Color(0xFFE3F2FD); // Azul clarinho
  static const Color highlight = Color(0xFFFFA726);      // Laranja claro para destaque
  static const Color textNormal = Color(0xFF0D47A1);     // Azul escuro
  static const Color borderCell = Color(0xFF90CAF9);     // Azul médio suave
  static const Color dot = Color(0xFFB0BEC5);             // Cinza azulado claro
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue,
    accentColor: AppColors.secondary,
    backgroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.secondary,
      foregroundColor: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.textNormal),
  ),
);
