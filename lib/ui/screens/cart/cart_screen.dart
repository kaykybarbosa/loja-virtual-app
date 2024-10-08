import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/ui/common/price_card.dart';
import 'package:lojavirtualapp/ui/screens/cart/widgets/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Carrinho')),
        body: Consumer<CartManager>(
          builder: (_, cart, __) => ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              /// Items
              Column(
                children: cart.items.map((product) => CartTile(product)).toList(),
              ),

              /// Preços
              PriceCard(
                buttonText: 'Continuar para Entrega',
                onPressed: cart.isCartValid
                    ? () {
                        context.push(AppRoutes.address);
                      }
                    : null,
              ),
            ],
          ),
        ),
      );
}
