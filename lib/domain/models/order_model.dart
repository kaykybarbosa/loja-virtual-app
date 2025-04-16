// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:lojavirtualapp/data/managers/cart_manager.dart';
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
  });

  OrderModel.fromCartManager(CartManager cart)
      : orderId = '',
        userId = cart.currentUser!.id,
        price = cart.totalPrice,
        items = List.from(cart.items),
        address = cart.address!,
        date = null;

  String userId;
  String orderId;
  num price;
  List<CartProductModel> items;
  AddressModel address;
  Timestamp? date;

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  @override
  List<Object?> get props => [userId, orderId, price, items, address, date];

  Future<void> save() async {
    _firestore.collection('orders').doc(orderId).set({
      'userId': userId,
      'price': price,
      'items': items.map((item) => item.toOrderItemMap()).toList(),
      'address': address.toMap(),
      'date': FieldValue.serverTimestamp(),
    });
  }
}
