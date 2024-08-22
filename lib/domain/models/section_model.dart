// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';
import 'package:lojavirtualapp/domain/models/section_item_model.dart';

class SectionModel extends Equatable {
  SectionModel({
    this.name = '',
    this.type = '',
    this.items = const [],
  });

  String name;
  String type;
  List<SectionItemModel> items;

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
      name: name ?? this.name,
      type: type ?? this.type,
      items: items ?? this.items.map((item) => item.copyWith()).toList(),
    );
  }
}
