import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/models/address_model.dart';
import 'package:lojavirtualapp/utils/extensions/time_of_day_extension.dart';

class StoreModel extends Equatable with ChangeNotifier {
  final String id;
  final String name;
  final String phone;
  final String image;
  final Map<String, Map<String, TimeOfDay>?> opening;
  final AddressModel address;

  StoreModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.image,
    required this.opening,
    required this.address,
  });

  @override
  List<Object?> get props => [id, name, phone, image, opening, address];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'image': image,
      'opening': opening,
      'address': address.toMap(),
    };
  }

  factory StoreModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return StoreModel(
      id: documentId ?? '',
      name: map['name'] as String,
      phone: map['phone'] as String,
      image: map['image'] as String,
      address: AddressModel.fromMap(map['address']),

      opening: (map['opening'] as Map<String, dynamic>).map((key, value) {
        final timesString = value as String?;

        if (timesString != null && timesString.isNotEmpty) {
          final splitted = timesString.split(RegExp(r'[:-]'));

          return MapEntry(key, {
            'from': TimeOfDay(
              hour: int.parse(splitted[0]),
              minute: int.parse(splitted[1]),
            ),
            'to': TimeOfDay(hour: int.parse(splitted[2]), minute: int.parse(splitted[3])),
          });
        } else {
          return MapEntry(key, null);
        }
      }),
    );
  }

  String toJson() => json.encode(toMap());

  factory StoreModel.fromJson(String source) => StoreModel.fromMap(json.decode(source));

  String get addressText =>
      '${address.street}, ${address.number}${address.complement!.isNotEmpty ? ' - ${address.complement}' : ''}'
      '${address.district}, ${address.city}/${address.state}';

  String get openintText {
    return 'Seg-Sex: ${formattedPeriod(opening['monfri'])}\n'
        'Sáb: ${formattedPeriod(opening['saturday'])}\n'
        'Dom: ${formattedPeriod(opening['sunday'])}\n';
  }

  String formattedPeriod(Map<String, TimeOfDay>? period) {
    if (period == null) return 'Fechada';

    return '${period['from']!.formatted} - ${period['to']!.formatted}';
  }
}
