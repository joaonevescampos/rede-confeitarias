import 'package:flutter/material.dart';
import 'package:rede_confeitarias/core/theme/constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
      ),
      scaffoldBackgroundColor: AppColors.primary,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        elevation: 0,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: AppColors.secondary),
        bodyMedium: TextStyle(color: Colors.black),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.quarternary,
        foregroundColor: AppColors.quarternary,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.secondary),
        ),
      ),
      useMaterial3: true,
    );
  }
}
