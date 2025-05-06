import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/orders_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/cart_product_model.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/ui/common/empty_card.dart';
import 'package:lojavirtualapp/ui/common/login_card.dart';
import 'package:provider/provider.dart';

part './widgets/_order_item_tile.dart';
part './widgets/_order_tile.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: Consumer<OrdersManager>(
        builder: (_, ordersManager, _) {
          if (ordersManager.currentUser == null) {
            return LoginCard();
          } else if (ordersManager.orders.isEmpty) {
            return EmptyCard(
              icon: Icons.border_clear_outlined,
              title: 'Nenhuma compra realizada.',
            );
          }

          return ListView.builder(
            itemCount: ordersManager.orders.length,
            itemBuilder: (_, i) {
              final OrderModel order = ordersManager.orders.reversed.toList()[i];

              return _OrderTile(order: order);
            },
          );
        },
      ),
    );
  }
}
