import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

export 'package:animated_snack_bar/animated_snack_bar.dart';

void customSnackbar(
  BuildContext context, {
  String message = '',
  type = AnimatedSnackBarType.success,
}) {
  AnimatedSnackBar.material(
    message,
    type: type,
    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
  ).show(context);
}
