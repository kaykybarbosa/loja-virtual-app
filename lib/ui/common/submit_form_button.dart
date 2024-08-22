import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class SubmitFormButton extends StatelessWidget {
  const SubmitFormButton({
    super.key,
    this.text = '',
    this.isLoading = false,
    this.width,
    this.height = 44,
    this.disablebackgroundColor,
    this.onPressed,
  });

  final String text;
  final bool isLoading;
  final double? width;
  final double? height;
  final Color? disablebackgroundColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(disabledBackgroundColor: disablebackgroundColor),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive(
                    valueColor: AlwaysStoppedAnimation(MyColors.base100),
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
        ),
      );
}
