import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/theme_data/app_bar_theme.dart';

abstract class TThemeData {
  static ThemeData light = ThemeData(
    useMaterial3: true,
    primaryColor: MyColors.primary,
    scaffoldBackgroundColor: MyColors.primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: TAppBarTheme.light,
    colorScheme: const ColorScheme.light(primary: MyColors.primary),
    textButtonTheme: const TextButtonThemeData(
      style: ButtonStyle(
        padding: WidgetStatePropertyAll(EdgeInsets.zero),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: MyColors.base100,
        backgroundColor: MyColors.primary,
      ),
    ),
  );
}
