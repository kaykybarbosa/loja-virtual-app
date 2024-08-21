// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';

class EditItemSize extends StatelessWidget {
  EditItemSize({
    super.key,
    required this.size,
    this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
  });

  ItemSizeModel size;
  final VoidCallback? onRemove;
  final VoidCallback? onMoveUp;
  final VoidCallback? onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /// Título
          Expanded(
            flex: 30,
            child: TextFormField(
              initialValue: size.name,
              decoration: const InputDecoration(
                isDense: true,
                labelText: 'Título',
              ),
              onChanged: (name) => size.name = name,
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'Inválido';
                }
                return null;
              },
            ),
          ),

          /// Estoque
          Expanded(
            flex: 30,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: TextFormField(
                initialValue: size.stock.toString(),
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  isDense: true,
                  labelText: 'Estoque',
                ),
                onChanged: (stock) => size.stock = int.tryParse(stock) ?? 0,
                validator: (stock) {
                  if (stock == null || int.tryParse(stock) == null) {
                    return 'Inválido';
                  }
                  return null;
                },
              ),
            ),
          ),

          /// Preço
          Expanded(
            flex: 40,
            child: TextFormField(
              initialValue: size.price.toStringAsFixed(2),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                isDense: true,
                prefixText: 'R\$',
                labelText: 'Preço',
              ),
              onChanged: (price) => size.price = num.tryParse(price) ?? 0.0,
              validator: (price) {
                if (price == null || num.tryParse(price) == null) {
                  return 'Inválido';
                }
                return null;
              },
            ),
          ),

          /// Ícones
          CustomIconButton(
            icon: MyIcons.remove,
            color: Theme.of(context).colorScheme.error,
            onTap: onRemove,
          ),
          CustomIconButton(
            icon: MyIcons.chevronUp,
            onTap: onMoveUp,
          ),
          CustomIconButton(
            icon: MyIcons.chevronDown,
            onTap: onMoveDown,
          ),
        ],
      ),
    );
  }
}
