part of '../address_screen.dart';

class _AddressCard extends StatelessWidget {
  const _AddressCard();

  @override
  Widget build(BuildContext context) {
    final cartManager = context.watch<CartManager>();
    final AddressModel? address = cartManager.address;
    final String complement = address?.complement ?? '';
    final num? deliveryPrice = cartManager.deliveryPrice;

    Future<void> setAddress(AddressModel address) async {
      try {
        await context.read<CartManager>().setAddress(address);
        customSnackbar(
          context,
          message: 'Endereço de entrega atualizado com sucesso!',
        );
      } catch (e) {
        customSnackbar(
          context,
          message: e.toString(),
          type: AnimatedSnackBarType.error,
        );
      }
    }

    Widget buildAddressSection() {
      if (address == null) return SizedBox();

      if (deliveryPrice == null) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /// Endereço
            _AddressInputField(address: address),

            SizedBox(height: 20),

            /// Botão Calcular Frete
            ElevatedButton(
              onPressed: () async {
                if (Form.of(context).validate()) {
                  Form.of(context).save();
                  setAddress(address);
                }
              },
              child: const Text('Calcular frete'),
            ),
          ],
        );
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Text(
          '${address.street}, ${address.number}${complement.isNotEmpty ? ',' : ''} $complement\n${address.district}\n${address.city} - ${address.state} ',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 4),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Endereço de Entrega',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            /// Form
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                /// -- CEP
                _CepInputField(adrress: address),

                SizedBox(height: 15),

                buildAddressSection(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
