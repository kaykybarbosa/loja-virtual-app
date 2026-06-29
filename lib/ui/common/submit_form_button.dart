import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class SubmitFormButton extends StatelessWidget {
  const SubmitFormButton({
    super.key,
    this.text = '',
    this.isLoading = false,
    this.width,
    this.disablebackgroundColor,
    this.onPressed,
    this.textStyle,
  });

  final String text;
  final bool isLoading;
  final double? width;
  final Color? disablebackgroundColor;
  final Function()? onPressed;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(disabledBackgroundColor: disablebackgroundColor),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation(AppColors.base100),
              ),
            )
          : Text(text, style: textStyle ?? const TextStyle(fontSize: 15)),
    ),
  );
}
