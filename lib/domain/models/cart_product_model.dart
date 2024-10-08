// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';

class CartProductModel extends Equatable with ChangeNotifier {
  CartProductModel({
    this.cartProductId,
    required this.product,
    required this.productId,
    required this.size,
    required this.quantity,
  });

  CartProductModel.fromProduct(this.product)
      : cartProductId = null,
        productId = product.id,
        quantity = 1,
        size = product.getSelectedSize?.name ?? '';

  String? cartProductId;
  final ProductModel product;
  final String productId;
  final String size;
  int quantity;
  static final _store = FirebaseFirestore.instance;

  // G E T T E R S

  ItemSizeModel? get itemSize => product.findSize(size);

  num get unitPrice => itemSize?.price ?? 0;

  bool get hasStock {
    final size = itemSize;

    if (size == null) return false;

    return size.stock >= quantity;
  }

  num get totalPrice => unitPrice * quantity;

  @override
  List<Object?> get props => [cartProductId, product, productId, size, quantity];

  // F U N C T I O N S

  static Future<CartProductModel> fromDocument(Map<String, dynamic> map, {String? cartProductId}) async {
    final productId = map['productId'];

    final result = await _store.collection('products').doc(productId).get();
    ProductModel product = ProductModel.fromMap(result.data() as Map<String, dynamic>);

    return CartProductModel(
      cartProductId: cartProductId,
      product: product,
      productId: productId,
      size: map['size'],
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'size': size,
        'quantity': quantity,
      };

  bool isStackable(ProductModel product) {
    return product.id == productId && (product.getSelectedSize?.name ?? '') == size;
  }

  CartProductModel copyWith({
    ProductModel? product,
    String? productId,
    String? size,
    int? quantity,
  }) {
    return CartProductModel(
      product: product ?? this.product,
      productId: productId ?? this.productId,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }

  void increment() => {quantity++, notifyListeners()};

  void decrement() => {quantity--, notifyListeners()};

  void notifyListerners() => notifyListeners();
}
