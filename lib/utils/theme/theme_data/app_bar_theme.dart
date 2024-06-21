import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

abstract class TAppBarTheme {
  static AppBarTheme light = const AppBarTheme(
    elevation: 0,
    backgroundColor: MyColors.primary,
  );
}
