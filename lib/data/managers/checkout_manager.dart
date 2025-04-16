import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';

class CheckoutManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CartManager cartManager;

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  void updateCart(CartManager cart) {
    cartManager = cart;
  }

  Future<void> checkout({
    Function(String e)? onStockFail,
    Function? onSuccess,
  }) async {
    loading = true;

    try {
      await _decrementStock();
    } catch (e) {
      if (onStockFail != null) onStockFail(e.toString());

      loading = false;
      return;
    }

    final int orderId = await _getOrderId();

    final OrderModel order = OrderModel.fromCartManager(cartManager);
    order.orderId = orderId.toString();

    await Future.wait([
      order.save(),
      cartManager.clear(),
    ]);

    if (onSuccess != null) onSuccess();

    loading = false;
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
