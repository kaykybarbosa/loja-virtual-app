import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/image_source_sheet.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';

class AddTitleWidget extends StatelessWidget {
  const AddTitleWidget({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File file) {}

    return GestureDetector(
      onTap: () {
        if (Platform.isAndroid) {
          showModalBottomSheet(
            context: context,
            builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected),
          );
        } else {
          showCupertinoModalPopup(
            context: context,
            builder: (_) => ImageSourceSheet(onImageSelected: onImageSelected),
          );
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: MyColors.base100.withAlpha(30),
            child: const Icon(
              MyIcons.plus,
              color: MyColors.base100,
            ),
          ),
        ),
      ),
    );
  }
}
