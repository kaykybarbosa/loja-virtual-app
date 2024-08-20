// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ItemSizeModel extends Equatable {
  const ItemSizeModel({
    this.name = '',
    this.price = 0,
    this.stock = 0,
  });

  final String name;
  final num price;
  final int stock;

  bool get hasStock => stock > 0;

  @override
  List<Object?> get props => [name, price, stock];

  Map<String, dynamic> toMap() => {
        'name': name,
        'price': price,
        'stock': stock,
      };

  factory ItemSizeModel.fromMap(Map<String, dynamic> map) => ItemSizeModel(
        name: map['name'] ?? '',
        price: map['price'] ?? 0,
        stock: map['stock'] ?? 0,
      );

  String toJson() => json.encode(toMap());

  factory ItemSizeModel.fromJson(String source) => ItemSizeModel.fromMap(json.decode(source));

  ItemSizeModel copyWith({
    String? name,
    num? price,
    int? stock,
  }) {
    return ItemSizeModel(
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
    );
  }
}
