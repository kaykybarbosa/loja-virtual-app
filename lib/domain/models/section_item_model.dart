// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class SectionItemModel extends Equatable {
  const SectionItemModel({this.image = ''});

  final String image;

  @override
  List<Object> get props => [image];

  Map<String, dynamic> toMap() => {
        'image': image,
      };

  factory SectionItemModel.fromMap(Map<String, dynamic> map) => SectionItemModel(
        image: map['image'],
      );
}
