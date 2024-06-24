import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/product_model.dart';

class ProductManager extends ChangeNotifier {
  ProductManager() {
    _loadAllProducts();
  }

  final _store = FirebaseFirestore.instance;
  List<ProductModel> _allProducts = [];
  String _search = '';

  Future<void> _loadAllProducts() async {
    final snapProducts = await _store.collection('products').get();

    _allProducts = snapProducts.docs
        .map((doc) => ProductModel.fromMap(
              doc.data(),
              documentId: doc.id,
            ))
        .toList();

    notifyListeners();
  }

  List<ProductModel> get filteredProducts {
    List<ProductModel> filteredProducts = [];

    if (_search.isEmpty) {
      filteredProducts.addAll(_allProducts);
    } else {
      filteredProducts.addAll(
        _allProducts.where((product) => product.name.toLowerCase().contains(_search.toLowerCase())),
      );
    }

    return filteredProducts;
  }

  // G E T T E R S
  List<ProductModel> get allProducts => _allProducts;

  String get getSearch => _search;

  /// S E T T E R S
  set search(String value) {
    _search = value;
    notifyListeners();
  }
}
