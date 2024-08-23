import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/product_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/section_item_model.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item});

  final SectionItemModel item;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          if (item.productId.isNotEmpty) {
            final product = context.read<ProductManager>().findProductById(item.productId);

            if (product != null) {
              context.push(AppRoutes.productDetails, extra: product);
            }
          }
        },
        child: AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: item.image is String
                ? FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: item.image,
                    fit: BoxFit.cover,
                  )
                : Image.file(item.image),
          ),
        ),
      );
}
