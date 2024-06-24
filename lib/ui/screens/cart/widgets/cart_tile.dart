import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/cart_product_model.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, {super.key});

  final CartProductModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: <Widget>[
            /// Imagem
            Image.network(
              cartProduct.product.images.first,
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),

            /// Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    /// -- Nome
                    Text(
                      cartProduct.product.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    /// -- Tamanho
                    Text(
                      'Tamanho: ${cartProduct.size}',
                      style: const TextStyle(
                        color: MyColors.base500,
                      ),
                    ),

                    /// -- Preço
                    Text(
                      'R\$ ${cartProduct.uniPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: MyColors.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
