import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';

class EditItemSize extends StatelessWidget {
  const EditItemSize({
    super.key,
    required this.size,
    this.onRemove,
    this.onMoveUp,
    this.onMoveDown,
  });

  final ItemSizeModel size;
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
              onChanged: (title) => size.copyWith(name: title),
              validator: (title) {
                if (title == null || title.isEmpty) {
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
                onChanged: (stock) => size.copyWith(stock: int.tryParse(stock)),
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
              onChanged: (price) => size.copyWith(price: num.tryParse(price)),
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
