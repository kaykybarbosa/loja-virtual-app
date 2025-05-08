part of '../orders_screen.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({super.key, required this.order});

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ExpansionTile(
        shape: Border(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                /// -- Id
                Text(
                  order.orderIdFormatter,
                  style: TextStyle(
                    fontSize: 16,
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                /// -- Preço
                Text(
                  'R\$ ${order.price.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                ),
              ],
            ),

            /// -- Status
            Text(
              order.status.label,
              style: TextStyle(
                color: order.status.isCanceled ? MyColors.warn : primaryColor,
              ),
            ),
          ],
        ),
        children: <Widget>[
          Column(
            children:
                order.items.map((item) => OrderItemTile(cartProduct: item)).toList(),
          ),
        ],
      ),
    );
  }
}
