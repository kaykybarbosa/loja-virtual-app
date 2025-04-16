import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/screens/address/address_screen.dart';
import 'package:lojavirtualapp/ui/screens/base/base_screen.dart';
import 'package:lojavirtualapp/ui/screens/cart/cart_screen.dart';
import 'package:lojavirtualapp/ui/screens/checkout/checkout_screen.dart';
import 'package:lojavirtualapp/ui/screens/home/sub_screens/select_product_screen.dart';
import 'package:lojavirtualapp/ui/screens/login/login_screen.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/edit_product_screen.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/product_details_screen.dart';
import 'package:lojavirtualapp/ui/screens/register/register_screen.dart';

final routerConfig = GoRouter(
  initialLocation: AppRoutes.base,
  routes: <RouteBase>[
    GoRoute(
      path: AppRoutes.base,
      builder: (context, state) => const BaseScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.productDetails,
      builder: (context, state) => ProductDetailsScreen(state.extra as ProductModel),
    ),
    GoRoute(
      path: AppRoutes.cart,
      builder: (context, state) => const CartScreen(),
    ),
    GoRoute(
      path: AppRoutes.editProduct,
      builder: (context, state) => EditProductScreen(state.extra as ProductModel?),
    ),
    GoRoute(
      path: AppRoutes.selectProduct,
      builder: (context, state) => const SelectProductScreen(),
    ),
    GoRoute(
      path: AppRoutes.address,
      builder: (context, state) => const AddressScreen(),
    ),
    GoRoute(
      path: AppRoutes.checkout,
      builder: (context, state) => const CheckoutScreen(),
    ),
  ],
);
