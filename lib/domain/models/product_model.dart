// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  const ProductModel({
    this.id = '',
    this.name = '',
    this.description = '',
    this.images = const [],
  });

  final String id;
  final String name;
  final String description;
  final List<String> images;

  @override
  List<Object?> get props => [id, name, description, images];

  Map<String, dynamic> toMap() => {
        'name': name,
        'description': description,
        'images': images,
      };

  factory ProductModel.fromMap(Map<String, dynamic> map, {String? documentId}) => ProductModel(
        id: documentId ?? '',
        name: map['name'],
        description: map['description'],
        images: List<String>.from((map['images'])),
      );

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) => ProductModel.fromMap(json.decode(source));
}
