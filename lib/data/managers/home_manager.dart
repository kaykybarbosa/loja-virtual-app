import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  final _store = FirebaseFirestore.instance;
  List<SectionModel> sections = [];
  bool _isLoading = false;

  Future<void> _loadSections() async {
    isLoading = true;
    _store.collection('home').snapshots().listen(
      (snapshot) {
        sections.clear();

        for (final document in snapshot.docs) {
          sections.add(SectionModel.fromMap(document.data()));
        }

        isLoading = false;
      },
    );
  }

  // G E T T E R S
  bool get getIsLoading => _isLoading;

  // S E T T E R S
  set isLoading(bool value) => {_isLoading = value, notifyListeners()};
}
