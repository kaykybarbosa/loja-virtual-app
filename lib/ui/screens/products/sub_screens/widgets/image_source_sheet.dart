import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
              ),
              child: const Text('Câmera'),
            ),
            TextButton(
              onPressed: () {},
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
              ),
              child: const Text('Galeria'),
            ),
          ],
        ),
      );
    } else {
      return CupertinoActionSheet(
        title: const Text('Selecionar foto para o item'),
        message: const Text('Escolha a origem da foto'),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Câmera'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {},
            child: const Text('Galeria'),
          ),
        ],
      );
    }
  }
}
