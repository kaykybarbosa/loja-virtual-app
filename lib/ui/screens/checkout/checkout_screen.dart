import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/data/managers/checkout_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/ui/common/price_card.dart';
import 'package:lojavirtualapp/ui/screens/checkout/widgets/credit_card.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:provider/provider.dart';

part 'widgets/_order_loading.dart';

class CheckoutScreen extends StatelessWidget {
  CheckoutScreen({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      lazy: false,
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) =>
          checkoutManager!..updateCart(cartManager),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pagamento')),
        body: Consumer<CheckoutManager>(
          builder: (_, checkout, _) => checkout.loading
              ? _OrderLoading()
              : Form(
                  key: formKey,
                  child: ListView(
                    children: <Widget>[
                      // Cartão de crédito
                      CreditCard(),

                      // Card dos preços
                      PriceCard(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            checkout.checkout(
                              onSuccess: (order) {
                                Navigator.of(context).popUntil(
                                  (route) => route.settings.name == AppRoutes.base,
                                );

                                context.push(AppRoutes.confirmation, extra: order);
                              },
                              onStockFail: (error) {
                                Navigator.of(context).popUntil(
                                  (route) => route.settings.name == AppRoutes.cart,
                                );

                                customSnackbar(
                                  context,
                                  message: error,
                                  type: AnimatedSnackBarType.error,
                                );
                              },
                            );
                          }
                        },
                        buttonText: 'Finalizar Pedido',
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
