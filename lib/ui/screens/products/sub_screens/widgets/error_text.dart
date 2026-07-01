import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText(this.error, {super.key, this.margin});

  final String error;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        error,
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}
