import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/cart_product_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/app_icons.dart';
import 'package:provider/provider.dart';

class CartTile extends StatelessWidget {
  const CartTile(this.cartProduct, {super.key});

  final CartProductModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: cartProduct,
      child: GestureDetector(
        onTap: () => context.push(AppRoutes.productDetails, extra: cartProduct.product),
        child: Card(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          style: const TextStyle(color: AppColors.base500),
                        ),

                        /// -- Preço
                        Consumer<CartProductModel>(
                          builder: (_, cartProduct, _) => cartProduct.hasStock
                              ? Text(
                                  'R\$ ${cartProduct.unitPrice.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : const Text(
                                  'Sem estoque suficiente!',
                                  style: TextStyle(color: AppColors.warn, fontSize: 12),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Botões
                Consumer<CartProductModel>(
                  builder: (_, cartProduct, _) => Column(
                    children: <Widget>[
                      /// -- Aumentar
                      CustomIconButton(
                        icon: AppIcons.plus,
                        toolTip: 'Adicionar',
                        color: Theme.of(context).primaryColor,
                        onTap: cartProduct.increment,
                      ),

                      /// -- Quantidade
                      Text(
                        '${cartProduct.quantity}',
                        style: const TextStyle(fontSize: 20),
                      ),

                      /// -- Diminuir
                      CustomIconButton(
                        icon: AppIcons.remove,
                        toolTip: 'Remover',
                        color: cartProduct.quantity > 1
                            ? Theme.of(context).primaryColor
                            : AppColors.warn,
                        onTap: cartProduct.decrement,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
