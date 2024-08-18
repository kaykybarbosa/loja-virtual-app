import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';
import 'package:lojavirtualapp/ui/screens/products/sub_screens/widgets/image_form.dart';

class EditProductScreen extends StatelessWidget {
  const EditProductScreen(this.product, {super.key});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Anúncio')),
      body: ListView(
        children: [
          ImageForm(product),
        ],
      ),
    );
  }
}
