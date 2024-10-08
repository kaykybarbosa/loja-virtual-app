part of '../address_screen.dart';

class _CepInputField extends StatefulWidget {
  const _CepInputField();

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            isDense: true,
            labelText: 'CEP',
            hintText: '12.345-678',
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
        const SizedBox(height: 5),
        ElevatedButton(
          onPressed: () async {
            if (Form.of(context).validate()) {
              context.read<CartManager>().getAddress(_controller.text);
            }
          },
          child: const Text('Buscar CEP'),
        )
      ],
    );
  }
}
