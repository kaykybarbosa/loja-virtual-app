import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/ui/common/my_back_button.dart';

class SearchDialog extends StatelessWidget {
  const SearchDialog({super.key, this.initialValue = ''});

  final String initialValue;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
            left: 4,
            top: 2,
            right: 4,
            child: Card(
              child: TextFormField(
                autofocus: true,
                initialValue: initialValue,
                textInputAction: TextInputAction.search,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 15),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  prefixIcon: MyBackButton(),
                ),
                onFieldSubmitted: (value) => context.pop(value),
              ),
            ),
          ),
        ],
      );
}
