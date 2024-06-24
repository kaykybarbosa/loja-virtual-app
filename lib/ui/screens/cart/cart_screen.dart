import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/ui/screens/cart/widgets/cart_tile.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Carrinho')),
      body: Consumer<CartManager>(
        builder: (_, cart, __) {
          return Column(
            children: cart.products.map((product) => CartTile(product)).toList(),
          );
        },
      ),
    );
  }
}
