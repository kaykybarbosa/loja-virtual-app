import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => context.push(AppRoutes.productDetails, extra: product),
      child: Card(
        child: Container(
          height: 100,
          padding: const EdgeInsets.all(8),
          child: Row(
            children: <Widget>[
              /// Imagem
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(product.images.first),
              ),
              const Gap(16),

              /// Produo
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    /// -- Nome
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const Gap(4),

                    /// -- A partir
                    const Text(
                      'A parte de',
                      style: TextStyle(
                        fontSize: 13,
                        color: MyColors.base500,
                      ),
                    ),

                    /// -- Preço
                    const Text(
                      'R\$ 19,99',
                      style: TextStyle(
                        color: MyColors.primary,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
