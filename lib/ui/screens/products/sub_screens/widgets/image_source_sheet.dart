import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  ImageSourceSheet({super.key, required this.onImageSelected});

  final Function(File file) onImageSelected;

  final picker = ImagePicker();

  void _callFunction(XFile? xFile) {
    if (xFile != null) {
      final file = File(xFile.path);

      onImageSelected(file);
    }
  }

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
              onPressed: () async {
                final result = await picker.pickImage(source: ImageSource.camera);

                _callFunction(result);
              },
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
              ),
              child: const Text('Câmera'),
            ),
            TextButton(
              onPressed: () async {
                final result = await picker.pickImage(source: ImageSource.gallery);

                _callFunction(result);
              },
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
        cancelButton: CupertinoActionSheetAction(
          onPressed: context.pop,
          child: const Text('Cancelar'),
        ),
        actions: <Widget>[
          CupertinoActionSheetAction(
            onPressed: () {},
            isDefaultAction: true,
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
