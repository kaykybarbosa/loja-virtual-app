import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:lojavirtualapp/utils/theme/theme_data/app_bar_theme.dart';

abstract class TThemeData {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: TAppBarTheme.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      error: AppColors.warn,
    ),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.zero)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.base100,
        backgroundColor: AppColors.primary,
        disabledBackgroundColor: AppColors.primary.withAlpha(100),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.base100,
      foregroundColor: AppColors.primary,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: AppColors.base500),
    ),
  );
}
