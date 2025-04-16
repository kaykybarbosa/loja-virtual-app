import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';

class CheckoutManager extends ChangeNotifier {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CartManager cartManager;

  void updateCart(CartManager cart) {
    cartManager = cart;
  }

  void checkout() async {
    _decrementStock();

    _getOrderId();
  }

  // U T I L S //

  void _decrementStock() {}

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
