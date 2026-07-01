// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lojavirtualapp/data/managers/product_manager.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/common/submit_form_button.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/image_form.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/sizes_form.dart';
import 'package:lojavirtualapp/utils/theme/colors/app_colors.dart';
import 'package:lojavirtualapp/utils/theme/icons/app_icons.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(ProductModel? product, {super.key})
    : product = product?.copyWith() ?? ProductModel().copyWith(),
      isEditing = product != null;

  ProductModel product;
  final bool isEditing;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    void updateProduct() {
      context.read<ProductManager>().update(product);

      context.pop();

      if (isEditing) context.pop();
    }

    return ChangeNotifierProvider.value(
      value: product,
      child: Scaffold(
        appBar: AppBar(
          title: Text(isEditing ? 'Editar Produto' : 'Adicionar Produto'),
          actions: [
            if (isEditing)
              IconButton(
                onPressed: () {
                  context.read<ProductManager>().delete(product);

                  context.pop();
                  context.pop();
                },
                icon: Icon(AppIcons.trash),
              ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              /// Imagens
              ImageForm(product),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    /// -- Nome
                    TextFormField(
                      initialValue: product.name,
                      decoration: const InputDecoration(
                        hintText: 'Título',
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                      validator: (name) {
                        if (name == null || name.isEmpty) {
                          return 'Título obrigatório';
                        } else if (name.length < 6) {
                          return 'Título muito curto';
                        }
                        return null;
                      },
                      onSaved: (name) => product.name = name!,
                    ),

                    /// -- A partir
                    const Text(
                      'A partir de',
                      style: TextStyle(fontSize: 14, color: AppColors.base500),
                    ),

                    /// -- Preço
                    const Text(
                      'R\$ ...',
                      style: TextStyle(
                        fontSize: 22,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    /// -- Descrição
                    const _SubTitle('Descrição'),
                    TextFormField(
                      initialValue: product.description,
                      decoration: const InputDecoration(
                        hintText: 'Descrição',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                      validator: (description) {
                        if (description == null || description.isEmpty) {
                          return 'Descrição obrigatório';
                        } else if (description.length < 10) {
                          return 'Descrição muito curta';
                        }
                        return null;
                      },
                      onSaved: (description) => product.description = description!,
                    ),

                    /// -- Tamanhos
                    SizesForm(product: product),

                    const SizedBox(height: 20),

                    /// -- Salvar
                    Consumer<ProductModel>(
                      builder: (_, product, child) {
                        return SubmitFormButton(
                          isLoading: product.loading,
                          disablebackgroundColor: AppColors.primary.withAlpha(100),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              await product.save();

                              updateProduct();
                            }
                          },
                          text: 'Salvar',
                        );
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

class _SubTitle extends StatelessWidget {
  const _SubTitle(this.title);

  final String title;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
  );
}
