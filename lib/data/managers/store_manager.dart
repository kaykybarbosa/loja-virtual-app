import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/store_model.dart';

class StoreManager extends ChangeNotifier {
  StoreManager() {
    _loadStoreList();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<StoreModel> _stores = [];

  List<StoreModel> get stores => _stores;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> _loadStoreList() async {
    _setIsLoading = true;

    final snapshot = await _firestore.collection('stores').get();

    _stores = snapshot.docs
        .map((doc) => StoreModel.fromMap(doc.data(), documentId: doc.id))
        .toList();

    _setIsLoading = false;
  }
}
