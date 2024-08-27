// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, empty_catches
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/section_item_model.dart';
import 'package:uuid/uuid.dart';

class SectionModel extends Equatable with ChangeNotifier {
  SectionModel({
    this.id = '',
    this.name = '',
    this.type = '',
    this.pos = 0,
    List<SectionItemModel>? items,
  })  : items = items ?? List.from([]),
        oficialItems = items != null ? List.from(items) : List.from([]);

  String id;
  String name;
  String type;
  int pos;

  List<SectionItemModel> items;
  List<SectionItemModel> oficialItems;

  String? _error;
  String? get error => _error;
  set _setError(String? value) => {_error = value, notifyListeners()};

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  DocumentReference get _firestoreRef => _firestore.doc('home/$id');

  Reference get _storageRef => _storage.ref().child('home').child(id);

  @override
  List<Object> get props => [
        name,
        type,
        items,
        oficialItems,
      ];

  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        'pos': pos,
        // 'items': items.map((item) => item.toMap()).toList(),
      };

  factory SectionModel.fromMap(Map<String, dynamic> map, {required String id}) => SectionModel(
        id: id,
        name: map['name'],
        type: map['type'],
        pos: map['pos'],
        items: map['items']?.map<SectionItemModel>((item) => SectionItemModel.fromMap(item)).toList(),
      );

  SectionModel copyWith({
    String? name,
    String? type,
    List<SectionItemModel>? items,
  }) {
    return SectionModel(
      id: id,
      name: name ?? '${this.name} ',
      type: type ?? this.type,
      items: items ?? this.items.map((item) => item.copyWith()).toList(),
    );
  }

  void addItem(SectionItemModel item) {
    items.add(item);

    notifyListeners();
  }

  void removeItem(SectionItemModel item) {
    items.remove(item);

    notifyListeners();
  }

  bool valid() {
    if (name.isEmpty) {
      _setError = 'Título inválido';
    } else if (items.isEmpty) {
      _setError = 'Insira ao menos uma imagem';
    } else {
      _setError = null;
    }

    return error == null;
  }

  Future<void> save(int pos) async {
    pos = pos;
    final data = toMap();

    /// Adicionando / Atualizando
    if (id.isEmpty) {
      final doc = await _firestore.collection('home').add(data);

      id = doc.id;
    } else {
      await _firestoreRef.update(data);
    }

    /// Adicionando imagens dos itens que não estão registrados
    final List<SectionItemModel> updateItems = [];

    for (final item in items) {
      if (item.image is File) {
        _storageRef.child(const Uuid().v1()).putFile(item.image).snapshotEvents.listen(
          (snapshot) async {
            if (snapshot.state == TaskState.success) {
              final String url = await snapshot.ref.getDownloadURL();

              item.image = url;

              updateItems.add(item);

              _updateItems(updateItems);
            }
          },
        );
      } else {
        updateItems.add(item);
      }
    }

    /// Removendo imagens dos items removidos
    try {
      for (final item in oficialItems) {
        if (!items.contains(item)) {
          final ref = _storage.refFromURL(item.image);

          await ref.delete();
        }
      }
    } catch (e) {
      log('ERRO AO DELETAR IMAGE DO ITEM: ${e.toString()}');
    }

    _updateItems(updateItems);
  }

  Future<void> delete() async {
    await _firestoreRef.delete();

    try {
      for (final item in items) {
        final ref = _storage.refFromURL(item.image);

        await ref.delete();
      }
    } catch (e) {}
  }

  Future<void> _updateItems(List<SectionItemModel> items) async {
    if (items.isEmpty) return;

    final itemsData = {
      'items': items.map((item) => item.toMap()).toList(),
    };

    await _firestoreRef.update(itemsData);
  }
}
