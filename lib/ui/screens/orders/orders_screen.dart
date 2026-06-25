import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/orders_manager.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/ui/common/empty_card.dart';
import 'package:lojavirtualapp/ui/common/login_card.dart';
import 'package:lojavirtualapp/ui/screens/orders/widgets/cancel_order_dialog.dart';
import 'package:lojavirtualapp/ui/screens/orders/widgets/export_address_dialog.dart';
import 'package:lojavirtualapp/ui/screens/orders/widgets/order_item_tile.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:provider/provider.dart';

part 'widgets/order_tile.dart';

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

              return OrderTile(order: order);
            },
          );
        },
      ),
    );
  }
}
