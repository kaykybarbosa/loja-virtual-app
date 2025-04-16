import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/data/managers/checkout_manager.dart';
import 'package:lojavirtualapp/data/routes/app_routes.dart';
import 'package:lojavirtualapp/ui/common/price_card.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<CartManager, CheckoutManager>(
      lazy: false,
      create: (_) => CheckoutManager(),
      update: (_, cartManager, checkoutManager) => checkoutManager!..updateCart(cartManager),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pagamento')),
        body: Consumer<CheckoutManager>(
          builder: (_, checkout, __) => ListView(
            children: <Widget>[
              PriceCard(
                onPressed: () {
                  checkout.checkout(
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
                },
                buttonText: 'Finalizar Pedido',
              )
            ],
          ),
        ),
      ),
    );
  }
}
