import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';

class OrdersManager extends ChangeNotifier {
  UserModel? _currentUser;

  final List<OrderModel> _orders = [];

  FirebaseFirestore get _firebase => FirebaseFirestore.instance;

  void updateUser(UserModel? user) {
    _currentUser = user;

    if (_currentUser != null) {
      _listenOrders();
    }
  }

  Future<void> _listenOrders() async {
    _firebase.collection('orders').where('userId', isEqualTo: _currentUser!.id).snapshots().listen(
      (snapshot) async {
        _orders.clear();
        for (final doc in snapshot.docs) {
          final order = await OrderModel.fromDocument(doc.data(), orderId: doc.id);

          _orders.add(order);
        }
      },
    );
  }
}
