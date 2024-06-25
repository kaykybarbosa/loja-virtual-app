// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';

// ignore: must_be_immutable
class ProductModel extends Equatable with ChangeNotifier {
  ProductModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.images = const [],
    this.sizes = const [],
    ItemSizeModel? selectedSize,
  }) : _selectedSize = selectedSize;

  final String id;
  final String name;
  final String description;
  final List<String> images;
  final List<ItemSizeModel> sizes;
  ItemSizeModel? _selectedSize;

  // G E T T E R S
  ItemSizeModel? get getSelectedSize => _selectedSize;

  int get totalStock {
    int totalStock = 0;

    for (var size in sizes) {
      totalStock += size.stock;
    }

    return totalStock;
  }

  bool get hasStock => totalStock > 0;

  ItemSizeModel? findSize(String name) {
    try {
      return sizes.firstWhere((size) => size.name == name);
    } catch (e) {
      return null;
    }
  }

  // S E T T E R S
  set selectedSize(ItemSizeModel size) {
    _selectedSize = size;
    notifyListeners();
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        images,
        sizes,
        _selectedSize,
      ];

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'images': images,
      };

  factory ProductModel.fromMap(Map<String, dynamic> map, {String? documentId}) => ProductModel(
        id: documentId ?? '',
        name: map['name'],
        description: map['description'],
        images: List<String>.from((map['images'])),
        sizes: map['sizes'].map<ItemSizeModel>((size) => ItemSizeModel.fromMap(size)).toList(),
      );

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
