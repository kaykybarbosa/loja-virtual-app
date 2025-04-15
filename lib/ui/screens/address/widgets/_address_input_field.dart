part of '../address_screen.dart';

class _AddressInputField extends StatelessWidget {
  const _AddressInputField({required this.address});

  final AddressModel address;

  String? emptyValidator(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório.';

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: <Widget>[
        /// Rua
        TextFormField(
          initialValue: address.street,
          decoration: InputDecoration(
            isDense: true,
            label: Text('Rua/Avenida*'),
            hintText: 'Rua/Avenida',
          ),
          validator: emptyValidator,
          onSaved: (value) => address.street = value ?? '',
        ),
        Row(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// -- Número
            Expanded(
              child: TextFormField(
                initialValue: address.number,
                decoration: InputDecoration(
                  isDense: true,
                  label: Text('Número*'),
                  hintText: 'Número',
                ),
                validator: emptyValidator,
                onSaved: (value) => address.number = value,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
            ),

            /// -- Complemento
            Expanded(
              child: TextFormField(
                initialValue: address.complement,
                decoration: InputDecoration(
                  isDense: true,
                  label: Text('Complemento'),
                  hintText: 'Complemento',
                ),
                onSaved: (value) => address.complement = value,
              ),
            ),
          ],
        ),

        /// Bairro
        TextFormField(
          initialValue: address.district,
          decoration: InputDecoration(
            isDense: true,
            label: Text('Bairro*'),
            hintText: 'Bairro',
          ),
          validator: emptyValidator,
          onSaved: (value) => address.district = value ?? '',
        ),

        Row(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// -- Cidade
            Expanded(
              flex: 3,
              child: TextFormField(
                initialValue: address.city,
                decoration: InputDecoration(
                  isDense: true,
                  label: Text('Cidade*'),
                  hintText: 'Cidade',
                ),
                validator: emptyValidator,
                onSaved: (value) => address.city = value ?? '',
              ),
            ),

            /// -- UF
            Expanded(
              child: TextFormField(
                maxLength: 2,
                autocorrect: false,
                initialValue: address.state,
                textCapitalization: TextCapitalization.characters,
                decoration: InputDecoration(
                  isDense: true,
                  counterText: '',
                  label: Text('UF*'),
                  hintText: 'UF',
                ),
                validator: (value) {
                  final validation = emptyValidator(value);

                  if (validation != null) {
                    return validation;
                  } else if (value!.length != 2) {
                    return 'UF inválido.';
                  }

                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
                ],
                onSaved: (value) => address.state = value ?? '',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
