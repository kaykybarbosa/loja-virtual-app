import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lojavirtualapp/utils/input_formatters.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class CreditCard extends StatelessWidget {
  CreditCard({super.key});

  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Cartão
          FlipCard(
            key: cardKey,
            flipOnTouch: false,
            direction: FlipDirection.HORIZONTAL,
            front: CardFront(),
            back: CardBack(),
            speed: 700,
          ),

          IconButton(
            visualDensity: VisualDensity.compact,
            icon: Text('Virar cartão', style: TextStyle(color: AppColors.base100)),
            onPressed: () => cardKey.currentState?.toggleCard(),
          ),
        ],
      ),
    );
  }
}

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
                    ),
                    CardTextField(
                      title: 'Validade',
                      hint: '00/0000',
                      textInputType: TextInputType.number,
                      inputFormatters: [InputFormatters.creditCardDate],
                    ),
                    CardTextField(
                      bold: true,
                      title: 'Nome',
                      hint: 'Nome do proprietário',
                      textInputType: TextInputType.text,
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

class CardTextField extends StatelessWidget {
  const CardTextField({
    super.key,
    this.bold = false,
    required this.title,
    required this.hint,
    this.textInputType,
    this.inputFormatters,
  });

  final String title;
  final bool bold;
  final String hint;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColors.base100,
            fontWeight: FontWeight.w400,
            fontSize: 10,
          ),
        ),

        // Field
        TextFormField(
          style: TextStyle(
            color: AppColors.base100,
            fontWeight: bold ? FontWeight.bold : null,
          ),
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 2),
          ),
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
        ),
      ],
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 16,
      color: AppColors.creditCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(16)),
      child: Container(height: 200),
    );
  }
}
