import 'dart:developer';

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
  bool _savingSections = false;

  Future<void> _loadSections() async {
    _setIsLoading = true;
    _store.collection('home').orderBy('pos').snapshots().listen(
      (snapshot) {
        _sections.clear();

        for (final document in snapshot.docs) {
          _sections.add(SectionModel.fromMap(document.data(), id: document.id));
        }

        _setIsLoading = false;
      },
    );
  }

  // G E T T E R S
  bool get isLoading => _isLoading;

  bool get savingSections => _savingSections;

  List<SectionModel> get sections => editing ? _editingSections : _sections;

  // S E T T E R S
  set _setIsLoading(bool value) => {_isLoading = value, notifyListeners()};

  set _setSavingSection(bool value) => {_savingSections = value, notifyListeners()};

  // M E T H O D S
  void enterEditing() {
    editing = true;

    _editingSections = _sections.map((section) => section.copyWith()).toList();

    notifyListeners();
  }

  Future<void> saveEditing() async {
    bool isValid = true;
    _setSavingSection = true;

    for (final section in _editingSections) {
      if (!section.valid()) {
        isValid = false;
      }
    }

    int pos = 0;

    if (isValid) {
      for (final section in _editingSections) {
        await section.save(pos);

        pos++;
      }

      for (final section in List.from(_sections)) {
        log('${section.name} - ${!sections.any((s) => s.id == section.id)} ${sections.length}', name: 'FIX');

        if (!_editingSections.any((s) => s.id == section.id)) {
          await section.delete();
        }
      }

      _setSavingSection = false;

      editing = false;
      notifyListeners();
    }
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
