import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualapp/data/managers/page_manager.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:lojavirtualapp/ui/screens/admin/admin_orders/admin_orders_screen.dart';
import 'package:lojavirtualapp/ui/screens/admin/admin_users/admin_users_screen.dart';
import 'package:lojavirtualapp/ui/screens/home/home_screen.dart';
import 'package:lojavirtualapp/ui/screens/orders/orders_screen.dart';
import 'package:lojavirtualapp/ui/screens/products/products_screen.dart';
import 'package:lojavirtualapp/ui/screens/stores/stores_screen.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => PageManager(_controller),
      child: Consumer<UserManager>(
        builder: (_, userManager, _) {
          return PageView(
            controller: _controller,
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              /// Início
              const HomeScreen(),

              /// Produtos
              const ProductsScreen(),

              /// Meus pedidos
              const OrdersScreen(),

              /// Lojas
              StoresScreen(),

              /// ADMIN
              if (userManager.adminEnabled) ...[
                /// -- Usuários
                const AdminUsersScreen(),

                /// -- Pedidos
                const AdminOrdersScreen(),
              ],
            ],
          );
        },
      ),
    );
  }
}
