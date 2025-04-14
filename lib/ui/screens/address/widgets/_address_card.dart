part of '../address_screen.dart';

class _AddressCard extends StatelessWidget {
  const _AddressCard({this.address});

  final AddressModel? address;

  @override
  Widget build(BuildContext context) {
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

                if (address != null) ...[
                  /// -- Endereço
                  _AddressInputField(address: address!),

                  SizedBox(height: 20),

                  /// -- Calcular frete btn
                  ElevatedButton(
                    onPressed: () async {
                      if (Form.of(context).validate()) {
                        Form.of(context).save();
                        setAddress(address!);
                      }
                    },
                    child: const Text('Calcular frete'),
                  )
                ]
              ],
            ),
          ],
        ),
      ),
    );
  }
}
