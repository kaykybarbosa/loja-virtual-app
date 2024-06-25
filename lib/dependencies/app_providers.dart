import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/data/managers/product_manager.dart';
import 'package:lojavirtualapp/data/managers/user_manager.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class AppProviders {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(
      lazy: false,
      create: (_) => UserManager(),
    ),
    ChangeNotifierProvider(
      lazy: false,
      create: (_) => ProductManager(),
    ),
    ChangeNotifierProxyProvider<UserManager, CartManager>(
      lazy: false,
      create: (_) => CartManager(),
      update: (_, userManager, cartManager) => cartManager!..updateUser(userManager),
    ),
  ];
}
