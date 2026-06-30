import 'package:flutter/material.dart';
import 'package:lojavirtualapp/ui/screens/checkout/widgets/card_text_field.dart';
import 'package:lojavirtualapp/utils/input_formatters.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class CardBack extends StatelessWidget {
  const CardBack({super.key, required this.cvvFocus});

  final FocusNode cvvFocus;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      color: AppColors.creditCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              height: 40,
              margin: EdgeInsets.symmetric(vertical: 16),
            ),

            Row(
              children: [
                Expanded(
                  flex: 70,
                  child: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.grey[500],
                    margin: EdgeInsets.only(left: 12),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: CardTextField(
                      title: '',
                      hint: '123',
                      textAlign: TextAlign.end,
                      textInputType: TextInputType.number,
                      inputFormatters: [InputFormatters.creditCardCvv],
                      validator: (value) {
                        if (value == null || value.length != 3) {
                          return '   inválido!';
                        }

                        return null;
                      },
                      onSubmitted: (_) {},
                      focusNode: cvvFocus,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                ),

                Expanded(flex: 30, child: SizedBox()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
