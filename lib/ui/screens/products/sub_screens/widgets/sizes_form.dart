import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/common/custom_icon_button.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/edit_item.size.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/error_text.dart';
import 'package:lojavirtualapp/utils/theme/icons/my_icons.dart';

class SizesForm extends StatelessWidget {
  const SizesForm({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<ItemSizeModel>>(
      initialValue: List.from(product.sizes),
      validator: (sizes) {
        if (sizes == null || sizes.isEmpty) {
          return 'Insira um tamanho';
        }
        return null;
      },
      builder: (state) {
        return Column(
          children: <Widget>[
            /// Titulo
            Row(
              children: <Widget>[
                const Expanded(
                  child: Text(
                    'Tamanhos',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomIconButton(
                  icon: MyIcons.plus,
                  onTap: () {
                    state.value?.add(const ItemSizeModel());
                    state.didChange(state.value);
                  },
                ),
              ],
            ),

            /// Tamanhos
            Column(
              children: state.value != null
                  ? state.value!
                      .map(
                        (size) => EditItemSize(
                          key: ValueKey(size),
                          size: size,
                          onRemove: () {
                            state.value?.remove(size);
                            state.didChange(state.value);
                          },
                          onMoveUp: state.value?.first != size
                              ? () {
                                  final index = state.value!.indexOf(size);

                                  state.value?.removeAt(index);
                                  state.value?.insert(index - 1, size);
                                  state.didChange(state.value);
                                }
                              : null,
                          onMoveDown: state.value!.last != size
                              ? () {
                                  final index = state.value!.indexOf(size);

                                  state.value?.removeAt(index);
                                  state.value?.insert(index + 1, size);
                                  state.didChange(state.value);
                                }
                              : null,
                        ),
                      )
                      .toList()
                  : [],
            ),
            if (state.hasError)
              ErrorText(
                '${state.errorText}',
                margin: const EdgeInsets.only(top: 16),
              )
          ],
        );
      },
    );
  }
}
