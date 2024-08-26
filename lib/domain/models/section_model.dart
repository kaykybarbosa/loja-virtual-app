// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
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
    List<SectionItemModel>? items,
    List<SectionItemModel>? newItems,
  })  : items = items ?? List.from([]),
        newItems = newItems ?? List.from([]);

  String id;
  String name;
  String type;
  List<SectionItemModel> items;
  List<SectionItemModel> newItems;

  String? _error;
  String? get error => _error;
  set _setError(String? value) => {_error = value, notifyListeners()};

  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  DocumentReference get _firestoreRef => _firestore.doc('home/$id');

  Reference get _storageRef => _storage.ref().child('sections').child(id);

  @override
  List<Object> get props => [
        name,
        type,
        items,
        newItems,
      ];

  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        // 'items': items.map((item) => item.toMap()).toList(),
      };

  factory SectionModel.fromMap(Map<String, dynamic> map, {required String id}) => SectionModel(
        id: id,
        name: map['name'],
        type: map['type'],
        items: map['items'].map<SectionItemModel>((item) => SectionItemModel.fromMap(item)).toList(),
      );

  SectionModel copyWith({
    String? name,
    String? type,
    List<SectionItemModel>? items,
  }) {
    return SectionModel(
      id: id,
      name: name ?? this.name,
      type: type ?? this.type,
      items: items ?? this.items.map((item) => item.copyWith()).toList(),
    );
  }

  void addItem(SectionItemModel item) {
    items.add(item);
    newItems.add(item);

    notifyListeners();
  }

  void removeItem(SectionItemModel item) {
    items.remove(item);
    newItems.remove(item);

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

  Future<void> save() async {
    final data = toMap();

    /// Adicionando / Atualizando
    if (id.isEmpty) {
      final doc = await _firestore.collection('home').add(data);

      id = doc.id;
    } else {
      _firestoreRef.update(data);
    }

    /// Adicionando imagens dos itens que não estão registrados
    List<SectionItemModel> updateItems = [];

    for (final item in newItems) {
      if (items.contains(item)) {
        updateItems.add(item);
      } else {
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
      }
    }

    /// Removendo imagens dos items removidos
    for (final item in items) {
      if (newItems.isNotEmpty && !newItems.contains(item)) {
        final ref = _storage.refFromURL(item.image);

        await ref.delete();
      }
    }

    if (updateItems.isNotEmpty) {
      _updateItems(updateItems);

      items = updateItems;
    }
  }

  void _updateItems(List<SectionItemModel> items) {
    _firestoreRef.update({'items': items});
  }
}
