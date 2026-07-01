import 'dart:async';

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

  Timer? _timer;

  Future<void> _loadStoreList() async {
    _setIsLoading = true;

    final snapshot = await _firestore.collection('stores').get();

    _stores = snapshot.docs
        .map((doc) => StoreModel.fromDocument(doc.data(), documentId: doc.id))
        .toList();

    _setIsLoading = false;
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(minutes: 1), (t) {
      _checkOpening();
    });
  }

  void _checkOpening() {
    for (var store in _stores) {
      store.updateStatus();
    }

    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();

    _timer?.cancel();
  }
}
