import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/ui/screens/checkout/widgets/card_front.dart';
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
