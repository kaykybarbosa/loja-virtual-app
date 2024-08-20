import 'package:flutter/material.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    this.icon,
    this.color,
    this.onTap,
    this.toolTip,
  });

  final IconData? icon;
  final Color? color;
  final VoidCallback? onTap;
  final String? toolTip;

  @override
  Widget build(BuildContext context) => Tooltip(
        message: toolTip ?? '',
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: onTap != null ? color : MyColors.base400,
            ),
          ),
        ),
      );
}
