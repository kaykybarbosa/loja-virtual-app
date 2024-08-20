import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/image_source_sheet.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';

class ImageForm extends StatelessWidget {
  const ImageForm(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: List.from(product.images),
      builder: (state) {
        void onImageSelected(File file) {
          state.value?.add(file);
          state.didChange(state.value);
          context.pop();
        }

        return FlutterCarousel(
          items: state.value?.map<Widget>((image) {
            return AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  if (image is String)
                    Image.network(
                      image,
                      fit: BoxFit.cover,
                    )
                  else
                    Image.file(
                      image,
                      fit: BoxFit.cover,
                    ),

                  /// Remover imagem
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      tooltip: 'Remover',
                      onPressed: () => {
                        state.value?.remove(image),
                        state.didChange(state.value),
                      },
                      icon: const Icon(
                        MyIcons.remove,
                        color: MyColors.warn,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList()
            ?..add(
              Container(
                width: double.infinity,
                color: MyColors.gray100,
                child: IconButton(
                  icon: const Icon(MyIcons.addPhoto),
                  color: Theme.of(context).primaryColor,
                  iconSize: 50,
                  onPressed: () {
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
                  highlightColor: Colors.transparent,
                ),
              ),
            ),
          options: CarouselOptions(
            height: 300,
            slideIndicator: CircularSlideIndicator(
              slideIndicatorOptions: SlideIndicatorOptions(
                currentIndicatorColor: MyColors.primary,
                indicatorBackgroundColor: MyColors.base400,
                indicatorRadius: 4,
                itemSpacing: 15,
              ),
            ),
          ),
        );
      },
    );
  }
}
