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
          for (final change in snapshot.docChanges) {
            switch (change.type) {
              case DocumentChangeType.added:
                final order = await OrderModel.fromDocument(
                  change.doc.data()!,
                  orderId: change.doc.id,
                );

                orders.add(order);
                break;
              case DocumentChangeType.modified:
                final modOrder = orders.firstWhere((o) => o.orderId == change.doc.id);

                modOrder.updateStatus(change.doc.data()!);

                break;
              default:
            }
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
