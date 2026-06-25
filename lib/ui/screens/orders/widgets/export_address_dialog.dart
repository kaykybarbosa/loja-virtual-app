import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:lojavirtualapp/domain/models/address_model.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:screenshot/screenshot.dart';

class ExportAddressDialog extends StatelessWidget {
  ExportAddressDialog({super.key, required this.address});

  final AddressModel address;

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    Future<void> capture() async {
      final imageBytes = await screenshotController.capture();

      if (imageBytes != null) {
        await ImageGallerySaverPlus.saveImage(imageBytes);
      }
    }

    return AlertDialog(
      title: Text('Endereço de Entrega'),
      content: Screenshot(
        controller: screenshotController,
        child: Container(
          color: MyColors.base100,
          padding: EdgeInsets.all(8),
          child: Text(
            '${address.street}, ${address.number}, ${address.complement}\n'
            '${address.district}\n'
            '${address.city}/${address.state}\n'
            '${address.zipCode}',
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => {context.pop(), capture()},
          child: Text('Exportar', style: TextStyle(color: MyColors.primary)),
        ),
      ],
      contentPadding: EdgeInsets.fromLTRB(16, 16, 8, 0),
    );
  }
}
