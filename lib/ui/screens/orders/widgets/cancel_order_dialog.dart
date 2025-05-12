import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';

class CancelOrderDialog extends StatelessWidget {
  const CancelOrderDialog({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Cancelar ${order.orderIdFormatter}?'),
      content: Text('Essa ação não poderá ser desfeita, deseja cancelar o pedido?'),
      actions: <Widget>[
        TextButton(onPressed: context.pop, child: Text('Agora não')),
        TextButton(
          onPressed: () => {order.cancel(), context.pop()},
          child: Text('Cancelar pedido', style: TextStyle(color: MyColors.warn)),
        ),
      ],
    );
  }
}
