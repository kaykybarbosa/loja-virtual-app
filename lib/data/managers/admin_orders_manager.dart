import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:lojavirtualapp/domain/enums/order_status.dart';
import 'package:lojavirtualapp/domain/models/order_model.dart';
import 'package:lojavirtualapp/domain/models/user_model.dart';

class AdminOrdersManager extends ChangeNotifier {
  StreamSubscription? _subscription;
  final List<OrderModel> _orders = [];
  UserModel? _userFilter;
  final List<OrderStatus> _statusFilter = [OrderStatus.preparing];

  // GETTERS //

  FirebaseFirestore get _firebase => FirebaseFirestore.instance;

  List<OrderModel> get orders => _orders;

  UserModel? get userFilter => _userFilter;

  List<OrderStatus> get statusFilter => _statusFilter;

  List<OrderModel> get filteredOrders {
    List<OrderModel> output = _orders.reversed.toList();

    if (userFilter != null) {
      output = output.where((o) => o.userId == userFilter!.id).toList();
    }

    if (_statusFilter.isNotEmpty) {
      return output.where((o) => _statusFilter.contains(o.status)).toList();
    }

    return output;
  }

  // SETTERS //

  set userFilter(UserModel? user) => {_userFilter = user, notifyListeners()};

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
        final order = await OrderModel.fromDocument({'orderId': doc.id, ...doc.data()});

        _orders.add(order);
      }

      notifyListeners();
    });
  }

  void setStatusFilter(OrderStatus status) {
    if (_statusFilter.contains(status)) {
      _statusFilter.remove(status);
    } else {
      _statusFilter.add(status);
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }
}
