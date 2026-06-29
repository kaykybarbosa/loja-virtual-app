import 'package:flutter/material.dart';

extension TimeOfDayExtension on TimeOfDay {
  String get formatted {
    return '$hour:${minute.toString().padLeft(2, '0')}';
  }
}
