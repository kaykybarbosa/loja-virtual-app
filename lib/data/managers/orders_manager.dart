import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';

class OrdersManager extends ChangeNotifier {
  UserModel? _currentUser;
  StreamSubscription? _subscription;
  final List<OrderModel> _orders = [];

  // GETTERS //

  FirebaseFirestore get _firebase => FirebaseFirestore.instance;

  UserModel? get currentUser => _currentUser;

  List<OrderModel> get orders => _orders;

  // METHODS //

  void updateUser(UserModel? user) {
    _currentUser = user;

    _orders.clear();
    _subscription?.cancel();

    if (_currentUser != null) {
      _listenOrders();
    }
  }

  Future<void> _listenOrders() async {
    _subscription = _firebase
        .collection('orders')
        .where('userId', isEqualTo: _currentUser!.id)
        .snapshots()
        .listen((snapshot) async {
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
