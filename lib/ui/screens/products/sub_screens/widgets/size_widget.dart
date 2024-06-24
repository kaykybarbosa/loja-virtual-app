import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:provider/provider.dart';

class SizeWidget extends StatelessWidget {
  const SizeWidget(this.size, {super.key});

  final ItemSizeModel size;

  @override
  Widget build(BuildContext context) {
    final product = context.watch<ProductModel>();
    final isSelected = size == product.getSelectedSize;
    Color color = MyColors.base500;

    if (!size.hasStock) {
      color = MyColors.warn50;
    } else if (isSelected) {
      color = MyColors.primary;
    }

    return GestureDetector(
      onTap: () {
        if (size.hasStock) {
          product.selectedSize = size;
        }
      },
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: color)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            /// Nome
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: color,
              child: Text(
                size.name,
                style: const TextStyle(color: MyColors.base100),
              ),
            ),

            /// Preço
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'R\$ ${size.price.toStringAsFixed(2)}',
                style: TextStyle(color: color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
