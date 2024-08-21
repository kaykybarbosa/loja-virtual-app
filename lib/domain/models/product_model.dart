// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';

class ProductModel extends Equatable with ChangeNotifier {
  ProductModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.images = const [],
    this.sizes = const [],
    ItemSizeModel? selectedSize,
    this.newImages = const [],
  }) : _selectedSize = selectedSize;

  String id;
  String name;
  String description;
  List<String> images;
  List<ItemSizeModel> sizes;
  ItemSizeModel? _selectedSize;
  List<dynamic> newImages;

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

  num get basePrice {
    num lowest = double.infinity;

    for (final size in sizes) {
      if (size.price < lowest && size.hasStock) {
        lowest = size.price;
      }
    }

    return lowest;
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
        newImages,
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

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    List<String>? images,
    List<ItemSizeModel>? sizes,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes.map((size) => size.copyWith()).toList(),
    );
  }
}
