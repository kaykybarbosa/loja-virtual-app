part of '../address_screen.dart';

class _CepInputField extends StatefulWidget {
  const _CepInputField({this.adrress});

  final AddressModel? adrress;

  @override
  State<_CepInputField> createState() => _CepInputFieldState();
}

class _CepInputFieldState extends State<_CepInputField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isLoading = context.watch<CartManager>().loading;

    if (widget.adrress == null) {
      return Column(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /// Textfield
          TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              isDense: true,
              enabled: !isLoading,
              labelText: 'CEP',
              hintText: '12345-678',
              hintStyle: TextStyle(color: MyColors.base500),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CepInputFormatter(ponto: false),
            ],
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Campo obrigatório.';
              } else if (value.length > 9) {
                return 'CEP inválido.';
              }
              return null;
            },
          ),

          /// Buscar CEP Btn
          SubmitFormButton(
            text: 'Buscar CEP',
            isLoading: isLoading,
            textStyle: TextStyle(),
            onPressed: () async {
              if (Form.of(context).validate()) {
                try {
                  await context.read<CartManager>().getAddress(_controller.text);
                } catch (e) {
                  customSnackbar(
                    context,
                    message: e.toString(),
                    type: AnimatedSnackBarType.error,
                  );
                }
              }
            },
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'CEP: ${widget.adrress?.zipCode.formatCep}',
            style: TextStyle(
              fontSize: 16,
              color: MyColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          CustomIconButton(
            onTap: context.read<CartManager>().removeAddress,
            icon: MyIcons.edit,
            color: MyColors.primary,
          ),
        ],
      );
    }
  }
}
