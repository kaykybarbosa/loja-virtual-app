// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/section_item_model.dart';

class SectionModel extends Equatable with ChangeNotifier {
  SectionModel({
    this.name = '',
    this.type = '',
    List<SectionItemModel>? items,
  }) : items = items ?? List.from([]);

  String name;
  String type;
  List<SectionItemModel> items;

  String? _error;
  String? get error => _error;
  set _setError(String? value) => {_error = value, notifyListeners()};

  @override
  List<Object> get props => [
        name,
        type,
        items,
      ];

  Map<String, dynamic> toMap() => {
        'name': name,
        'type': type,
        'items': items,
      };

  factory SectionModel.fromMap(Map<String, dynamic> map) => SectionModel(
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

  void valid() {
    if (name.isEmpty) {
      _setError = 'Título inválido';
    } else if (items.isEmpty) {
      _setError = 'Insira ao menos uma imagem';
    } else {
      _setError = null;
    }
  }
}
