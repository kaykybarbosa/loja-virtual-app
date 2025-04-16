import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';

class CheckoutManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CartManager cartManager;

  void updateCart(CartManager cart) {
    cartManager = cart;
  }

  Future<void> checkout({Function(String e)? onStockFail}) async {
    try {
      await _decrementStock();
    } catch (e) {
      if (onStockFail != null) onStockFail(e.toString());
    }

    _getOrderId();
  }

  // U T I L S //

  Future<void> _decrementStock() async {
    final List<ProductModel> productsToUpdate = [];
    final List<ProductModel> productsWithoutStock = [];

    return firestore.runTransaction((tx) async {
      for (final cartProduct in cartManager.items) {
        ProductModel product;

        if (productsToUpdate.any((p) => p.id == cartProduct.productId)) {
          product = productsToUpdate.firstWhere((p) => p.id == cartProduct.productId);
        } else {
          final doc = await tx.get(firestore.doc('products/${cartProduct.productId}'));

          product = ProductModel.fromMap(doc.data()!, documentId: doc.id);
        }

        // Atualizando produto no carrinho
        cartProduct.setProduct(product);

        // Verifica se o produto possui estoque
        final ItemSizeModel? size = product.findSize(cartProduct.size);

        if (size!.stock - cartProduct.quantity < 0) {
          productsWithoutStock.add(product);
        } else {
          size.stock -= cartProduct.quantity;
          productsToUpdate.add(product);
        }
      }

      if (productsWithoutStock.isNotEmpty) {
        return Future.error('${productsWithoutStock.length} produto(s) sem estoque.');
      }

      for (final product in productsToUpdate) {
        final ref = firestore.doc('products/${product.id}');

        tx.update(ref, {'sizes': product.exportSizeList()});
      }
    });
  }

  Future<int> _getOrderId() async {
    final ref = firestore.doc('aux/ordercounter');

    try {
      final Map<String, int> result = await firestore.runTransaction((tx) async {
        final doc = await tx.get(ref);

        final int orderId = doc.data()!['current'];

        tx.update(ref, {'current': orderId + 1});

        return {'orderId': orderId};
      });

      return result['orderId']!;
    } catch (e) {
      return Future.error('Falha ao recuperar número do pedido.');
    }
  }
}
