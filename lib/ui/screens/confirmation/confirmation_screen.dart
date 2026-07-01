import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/ui/screens/orders/widgets/order_item_tile.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pedido confirmado')),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16),
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(16),
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  /// -- Id do pedido
                  Text(
                    order.orderIdFormatter,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),

                  /// -- Preço
                  Text(
                    'R\$ ${order.price.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                ],
              ),

              /// Produtos
              ...order.items.map((item) => OrderItemTile(cartProduct: item)),
            ],
          ),
        ),
      ),
    );
  }
}
