import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';

class MyBackButton extends StatelessWidget {
  const MyBackButton({super.key, this.color, this.onPressed});

  final Color? color;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: 'Voltar',
        onPressed: onPressed ?? () => context.pop(),
        icon: Icon(
          Platform.isAndroid ? MyIcons.arrowBack : MyIcons.arrowBackIOS,
          color: color,
        ),
      );
}
