import 'package:flutter/material.dart';

class SubmitFormButton extends StatelessWidget {
  const SubmitFormButton({
    super.key,
    this.text = '',
    this.isLoading = false,
    this.width,
    this.height = 44,
    this.onPressed,
  });

  final String text;
  final bool isLoading;
  final double? width;
  final double? height;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: onPressed,
          child: isLoading
              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator.adaptive())
              : Text(
                  text,
                  style: const TextStyle(fontSize: 18),
                ),
        ),
      );
}
