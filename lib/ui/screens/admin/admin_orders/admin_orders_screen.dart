import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/sliding_up_panel_widget.dart';
import 'package:lojavirtualapp/data/managers/admin_orders_manager.dart';
import 'package:lojavirtualapp/domain/enums/order_status.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';
import 'package:lojavirtualapp/ui/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/ui/common/empty_card.dart';
import 'package:lojavirtualapp/ui/screens/orders/orders_screen.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/app_icons.dart';
import 'package:provider/provider.dart';

part './widgets/_user_filter.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SlidingUpPanelController panelController = SlidingUpPanelController();

    return Stack(
      children: <Widget>[
        Scaffold(
          drawer: const CustomDrawer(),
          appBar: AppBar(title: const Text('Todos os Pedidos')),
          body: Consumer<AdminOrdersManager>(
            builder: (_, ordersManager, _) {
              final UserModel? userFilter = ordersManager.userFilter;
              final List<OrderModel> filteredOrders = ordersManager.filteredOrders;

              return Column(
                mainAxisAlignment:
                    filteredOrders.isEmpty
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.start,
                children: <Widget>[
                  if (userFilter != null)
                    /// Usuário filtrado
                    _UserFilter(userFilter: userFilter),

                  if (filteredOrders.isEmpty)
                    Expanded(
                      child: EmptyCard(
                        icon: Icons.border_clear_outlined,
                        title: 'Nenhum pedido realizado.',
                      ),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: filteredOrders.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (_, i) {
                          final OrderModel order = filteredOrders[i];

                          return OrderTile(order: order, showControls: true);
                        },
                      ),
                    ),
                ],
              );
            },
          ),
        ),

        /// Filtros
        SlidingUpPanelWidget(
          controlHeight: 60,
          panelController: panelController,
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.base100,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Filtros',
                    style: TextStyle(
                      fontSize: 17,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),

                ...OrderStatus.values.map((status) {
                  return Consumer<AdminOrdersManager>(
                    builder: (_, orderManager, _) {
                      return CheckboxListTile.adaptive(
                        dense: true,
                        title: Text(status.label),
                        value: orderManager.statusFilter.contains(status),
                        onChanged: (value) => orderManager.setStatusFilter(status),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
