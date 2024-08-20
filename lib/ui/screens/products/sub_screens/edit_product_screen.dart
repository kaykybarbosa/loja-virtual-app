import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/common/submit_form_button.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/image_form.dart';

class EditProductScreen extends StatelessWidget {
  EditProductScreen(this.product, {super.key});

  final ProductModel product;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Anúncio')),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            ImageForm(product),
            SubmitFormButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {}
              },
              text: 'Salvar',
            ),
          ],
        ),
      ),
    );
  }
}
