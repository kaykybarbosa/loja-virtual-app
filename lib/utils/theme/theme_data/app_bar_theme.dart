import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

abstract class TAppBarTheme {
  static AppBarTheme get light => const AppBarTheme(
    elevation: 0,
    centerTitle: true,
    foregroundColor: AppColors.base100,
    backgroundColor: AppColors.primary,
  );
}
