// ignore_for_file: must_be_immutable, empty_catches

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/item_size_model.dart';
import 'package:uuid/uuid.dart';

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

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

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

  DocumentReference get firestoreRef => _firestore.doc('products/$id');

  Reference get storageRef => _storage.ref().child('products').child(id);

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
        // 'images': images,
        'sizes': sizes.map((size) => size.toMap()).toList(),
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

  Future<void> save() async {
    final data = toMap();

    if (id.isEmpty) {
      final doc = await _firestore.collection('products').add(data);

      id = doc.id;
    } else {
      await firestoreRef.update(data);
    }

    /// Verificando se possui novas imagens
    List<String> updateImages = [];

    for (final newImage in newImages) {
      if (images.contains(newImage)) {
        updateImages.add(newImage);
      } else {
        storageRef.child(const Uuid().v1()).putFile(newImage).snapshotEvents.listen(
          (snapshot) async {
            if (snapshot.state == TaskState.success) {
              final String url = await snapshot.ref.getDownloadURL();

              updateImages.add(url);

              _updateImages(updateImages);
            }
          },
        );
      }
    }

    /// Removendo imagens
    for (final image in images) {
      if (!newImages.contains(image)) {
        final ref = _storage.refFromURL(image);

        await ref.delete();
      }
    }

    if (updateImages.isNotEmpty) _updateImages(updateImages);
  }

  void _updateImages(List<String> images) {
    firestoreRef.update({'images': images});
  }
}
