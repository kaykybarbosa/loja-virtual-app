import 'package:flutter/material.dart';
import 'package:lojavirtualapp/ui/screens/checkout/widgets/card_text_field.dart';
import 'package:lojavirtualapp/utils/input_formatters.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class CardFront extends StatelessWidget {
  const CardFront({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      color: AppColors.creditCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
          height: 200,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CardTextField(
                      bold: true,
                      title: 'Número',
                      hint: '0000 0000 0000 0000',
                      textInputType: TextInputType.number,
                      inputFormatters: [InputFormatters.creditCardNumber],
                      validator: (value) {
                        if (value == null || value.length != 19) {
                          return '   inválido!';
                        }

                        return null;
                      },
                    ),
                    CardTextField(
                      title: 'Validade',
                      hint: '00/0000',
                      textInputType: TextInputType.number,
                      inputFormatters: [InputFormatters.creditCardDate],
                      validator: (value) {
                        if (value == null || value.length != 7) {
                          return '   inválido!';
                        }

                        return null;
                      },
                    ),
                    CardTextField(
                      bold: true,
                      title: 'Nome',
                      hint: 'Nome do proprietário',
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '   inválido!';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
