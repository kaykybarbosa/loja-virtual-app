import 'package:flutter/material.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
