import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/utils/theme/colors/my_colors.dart';
import 'package:provider/provider.dart';

part 'widgets/_address_card.dart';
part 'widgets/_cep_input_field.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrega'),
      ),
      body: Consumer<CartManager>(
        builder: (_, cart, __) {
          return Form(
            child: ListView(
              children: const [
                _AddressCard(),
              ],
            ),
          );
        },
      ),
    );
  }
}
