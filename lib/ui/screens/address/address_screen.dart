import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/domain/models/address_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/ui/common/price_card.dart';
import 'package:lojavirtualapp/utils/extensions/string_extension.dart';
import 'package:lojavirtualapp/utils/messages/custom_snackbar.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';
import 'package:provider/provider.dart';

part 'widgets/_address_card.dart';
part 'widgets/_address_input_field.dart';
part 'widgets/_cep_input_field.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            /// Endereço
            _AddressCard(),

            /// Preço
            Consumer<CartManager>(
              builder: (_, cart, __) => PriceCard(
                buttonText: 'Continuar para pagamento',
                onPressed: cart.isAddressValid ? () {} : null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
