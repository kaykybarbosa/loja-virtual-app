import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';

class AdminOrdersManager extends ChangeNotifier {
  StreamSubscription? _subscription;
  final List<OrderModel> _orders = [];

  // GETTERS //

  FirebaseFirestore get _firebase => FirebaseFirestore.instance;

  List<OrderModel> get orders => _orders;

  // METHODS //

  void updateAdmin({required bool adminEnabled}) {
    _orders.clear();
    _subscription?.cancel();

    if (adminEnabled) _listenOrders();
  }

  Future<void> _listenOrders() async {
    _subscription = _firebase.collection('orders').snapshots().listen((snapshot) async {
      _orders.clear();
      for (final doc in snapshot.docs) {
        final order = await OrderModel.fromDocument(doc.data(), orderId: doc.id);

        _orders.add(order);
      }

      notifyListeners();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
