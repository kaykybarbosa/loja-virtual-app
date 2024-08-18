import 'package:flutter/material.dart';

abstract class MyColors {
  static const Color primary = Color.fromARGB(255, 4, 125, 141);

  static const Color base100 = Colors.white;
  static Color gray100 = Colors.grey[100]!;
  static Color base300 = Colors.grey[300]!;
  static Color base400 = Colors.grey[400]!;
  static const Color base500 = Colors.grey;

  static const Color gradient = Color.fromARGB(255, 203, 236, 241);

  static const Color gradientHome1 = Color.fromARGB(255, 211, 118, 130);
  static const Color gradientHome2 = Color.fromARGB(255, 253, 181, 168);

  static const Color warn = Colors.red;
  static Color warn50 = Colors.red.withAlpha(50);
}
