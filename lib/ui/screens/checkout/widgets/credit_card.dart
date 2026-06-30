import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:lojavirtualapp/ui/screens/checkout/widgets/card_back.dart';
import 'package:lojavirtualapp/ui/screens/checkout/widgets/card_front.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';

class CreditCard extends StatefulWidget {
  const CreditCard({super.key});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final FocusNode numberFocus = FocusNode();

  final FocusNode dateFocus = FocusNode();

  final FocusNode nameFocus = FocusNode();

  final FocusNode cvvFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      autoScroll: false,
      config: KeyboardActionsConfig(
        keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
        keyboardBarColor: Colors.grey[200],
        actions: [
          KeyboardActionsItem(focusNode: numberFocus, displayDoneButton: false),
          KeyboardActionsItem(focusNode: dateFocus, displayDoneButton: false),
          KeyboardActionsItem(
            focusNode: nameFocus,
            toolbarButtons: [
              (_) {
                return GestureDetector(
                  onTap: () {
                    cardKey.currentState?.toggleCard();
                    cvvFocus.requestFocus();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text('CONTINUAR'),
                  ),
                );
              },
            ],
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Cartão
            FlipCard(
              speed: 700,
              key: cardKey,
              flipOnTouch: false,
              direction: FlipDirection.HORIZONTAL,
              front: CardFront(
                numberFocus: numberFocus,
                dateFocus: dateFocus,
                nameFocus: nameFocus,
                onFinish: () {
                  cardKey.currentState?.toggleCard();
                  cvvFocus.requestFocus();
                },
              ),
              back: CardBack(cvvFocus: cvvFocus),
            ),

            IconButton(
              visualDensity: VisualDensity.compact,
              icon: Text('Virar cartão', style: TextStyle(color: AppColors.base100)),
              onPressed: () => cardKey.currentState?.toggleCard(),
            ),
          ],
        ),
      ),
    );
  }
}
