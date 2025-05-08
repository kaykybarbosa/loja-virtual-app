// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
import 'package:lojavirtualapp/domain/enums/order_status.dart';
import 'package:lojavirtualapp/domain/models/address_model.dart';
import 'package:lojavirtualapp/domain/models/cart_product_model.dart';

class OrderModel extends Equatable {
  OrderModel({
    required this.userId,
    required this.orderId,
    required this.price,
    required this.items,
    required this.address,
    this.date,
    required this.status,
  });

  OrderModel.fromCartManager(CartManager cart)
    : orderId = '',
      userId = cart.currentUser!.id,
      price = cart.totalPrice,
      items = List.from(cart.items),
      address = cart.address!,
      date = null,
      status = OrderStatus.preparing;

  String userId;
  String orderId;
  num price;
  List<CartProductModel> items;
  AddressModel address;
  Timestamp? date;
  OrderStatus status;

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  DocumentReference get _orderRef => _firestore.collection('orders').doc(orderId);

  String get orderIdFormatter => '#${orderId.padLeft(6, '0')}';

  @override
  List<Object?> get props => [userId, orderId, price, items, address, date];

  Future<void> save() async {
    _orderRef.set({
      'userId': userId,
      'price': price,
      'items': items.map((item) => item.toOrderItemMap()).toList(),
      'address': address.toMap(),
      'date': FieldValue.serverTimestamp(),
      'status': status.index,
    });
  }

  static Future<OrderModel> fromDocument(
    Map<String, dynamic> doc, {
    required String orderId,
  }) async {
    final List<CartProductModel> items = [];

    final futureItems =
        doc['items']
            .map((item) async => await CartProductModel.fromOrderItem(item))
            .toList();

    for (final futureItem in futureItems) {
      final item = await futureItem;

      items.add(item);
    }

    return OrderModel(
      userId: doc['userId'],
      orderId: orderId,
      price: doc['price'],
      items: items,
      address: AddressModel.fromMap(doc['address']),
      date: doc['date'],
      status: OrderStatus.values[doc['status'] ?? OrderStatus.preparing.index],
    );
  }

  void updateStatus(Map<String, dynamic> doc) {
    status = OrderStatus.values[doc['status'] ?? OrderStatus.preparing.index];
  }

  VoidCallback? get back =>
      status.index >= OrderStatus.transporting.index
          ? () => _updateStatus(OrderStatus.values[status.index - 1].index)
          : null;

  VoidCallback? get advance =>
      status.index <= OrderStatus.transporting.index
          ? () => _updateStatus(OrderStatus.values[status.index + 1].index)
          : null;

  VoidCallback? get cancel => () => _updateStatus(OrderStatus.canceled.index);

  void _updateStatus(int index) => _orderRef.update({'status': index});
}
