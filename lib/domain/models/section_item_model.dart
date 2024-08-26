// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';

class SectionItemModel extends Equatable {
  SectionItemModel({this.image = '', this.productId = ''});

  dynamic image;
  String productId;

  @override
  List<Object> get props => [image, productId];

  Map<String, dynamic> toMap() => {
        'image': image,
        'productId': productId,
      };

  factory SectionItemModel.fromMap(Map<String, dynamic> map) => SectionItemModel(
        image: map['image'],
        productId: map['productId'] ?? '',
      );

  SectionItemModel copyWith({
    dynamic image,
    String? productId,
  }) {
    return SectionItemModel(
      image: image ?? this.image,
      productId: productId ?? this.productId,
    );
  }
}
