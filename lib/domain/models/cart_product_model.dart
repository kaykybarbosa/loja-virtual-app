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
    this.fixedPrice,
  });

  CartProductModel.fromProduct(this.product)
      : cartProductId = null,
        fixedPrice = null,
        productId = product.id,
        quantity = 1,
        size = product.getSelectedSize?.name ?? '';

  String? cartProductId;
  ProductModel product;
  final String productId;
  final String size;
  int quantity;
  final num? fixedPrice;

  // G E T T E R S

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ItemSizeModel? get itemSize => product.findSize(size);

  num get unitPrice => itemSize?.price ?? 0;

  bool get hasStock {
    final size = itemSize;

    if (size == null) return false;

    return size.stock >= quantity;
  }

  num get totalPrice => unitPrice * quantity;

  @override
  List<Object?> get props => [cartProductId, product, productId, size, quantity, fixedPrice];

  // S E T T E R S
  void setProduct(ProductModel product) {
    this.product = product;
    notifyListeners();
  }

  // F U N C T I O N S

  static Future<DocumentSnapshot<Map<String, dynamic>>> _getProductById(String productId) async {
    return await _firestore.collection('products').doc(productId).get();
  }

  static Future<CartProductModel> fromDocument(Map<String, dynamic> map, {String? cartProductId}) async {
    final productId = map['productId'];

    final result = await _getProductById(productId);
    ProductModel product = ProductModel.fromMap(result.data() as Map<String, dynamic>);

    return CartProductModel(
      cartProductId: cartProductId,
      product: product,
      productId: productId,
      size: map['size'],
      quantity: map['quantity'],
    );
  }

  static Future<CartProductModel> fromOrderItem(Map<String, dynamic> map) async {
    final String productId = map['productId'];

    final result = await _getProductById(productId);
    ProductModel product = ProductModel.fromMap(result.data() as Map<String, dynamic>);

    return CartProductModel(
      product: product,
      productId: productId,
      size: map['size'],
      quantity: map['quantity'],
      fixedPrice: map['fixedPrice'],
    );
  }

  Map<String, dynamic> toMap() => {
        'productId': productId,
        'size': size,
        'quantity': quantity,
      };

  Map<String, dynamic> toOrderItemMap() => {
        'productId': productId,
        'size': size,
        'quantity': quantity,
        'fixedPrice': fixedPrice ?? unitPrice,
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
