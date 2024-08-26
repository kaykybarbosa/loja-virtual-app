import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/section_model.dart';

class HomeManager extends ChangeNotifier {
  HomeManager() {
    _loadSections();
  }

  final _store = FirebaseFirestore.instance;

  final List<SectionModel> _sections = [];
  List<SectionModel> _editingSections = [];

  bool editing = false;

  bool _isLoading = false;

  Future<void> _loadSections() async {
    _setIsLoading = true;
    _store.collection('home').snapshots().listen(
      (snapshot) {
        _sections.clear();

        for (final document in snapshot.docs) {
          _sections.add(SectionModel.fromMap(document.data()));
        }

        _setIsLoading = false;
      },
    );
  }

  // G E T T E R S
  bool get isLoading => _isLoading;

  List<SectionModel> get sections {
    return editing ? _editingSections : _sections;
  }

  // S E T T E R S
  set _setIsLoading(bool value) => {_isLoading = value, notifyListeners()};

  // M E T H O D S
  void enterEditing() {
    editing = true;

    _editingSections = _sections.map((section) => section.copyWith()).toList();

    notifyListeners();
  }

  void saveEditing() {
    for (final section in _editingSections) {
      section.valid();
    }

    // editing = false;
    // notifyListeners();
  }

  void discardEditing() {
    editing = false;
    notifyListeners();
  }

  void addSection(SectionModel section) {
    _editingSections.add(section);

    notifyListeners();
  }

  void removeSection(SectionModel section) {
    _editingSections.remove(section);

    notifyListeners();
  }
}
