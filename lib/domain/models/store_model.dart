import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtualapp/domain/enums/store_enum.dart';
import 'package:lojavirtualapp/domain/models/address_model.dart';
import 'package:lojavirtualapp/utils/extensions/time_of_day_extension.dart';

class StoreModel extends Equatable with ChangeNotifier {
  late String id;
  late String name;
  late String phone;
  late String image;
  late Map<String, Map<String, TimeOfDay>?> opening;
  late AddressModel address;
  late StoreStatus status;

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

  StoreModel.fromDocument(Map<String, dynamic> map, {String? documentId}) {
    id = documentId ?? '';
    name = map['name'] as String;
    phone = map['phone'] as String;
    image = map['image'] as String;
    address = AddressModel.fromMap(map['address']);

    opening = (map['opening'] as Map<String, dynamic>).map((key, value) {
      final timesString = value as String?;

      if (timesString != null && timesString.isNotEmpty) {
        final splitted = timesString.split(RegExp(r'[:-]'));

        return MapEntry(key, {
          'from': TimeOfDay(hour: int.parse(splitted[0]), minute: int.parse(splitted[1])),
          'to': TimeOfDay(hour: int.parse(splitted[2]), minute: int.parse(splitted[3])),
        });
      } else {
        return MapEntry(key, null);
      }
    });

    updateStatus();
  }

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

  String get statusText {
    switch (status) {
      case StoreStatus.closed:
        return 'Fechada';
      case StoreStatus.open:
        return 'Aberta';
      case StoreStatus.closing:
        return 'Fechando';
    }
  }

  String get cleanPhone => phone.replaceAll(RegExp(r"[^\d]"), '');

  void updateStatus() {
    final weekDay = DateTime.now().weekday;

    Map<String, TimeOfDay>? period;

    // Maior que Segunda && Menor que Sexta
    if (weekDay >= 1 && weekDay <= 5) {
      period = opening['monfri'];
    } else if (weekDay == 6) {
      period = opening['saturday'];
    } else {
      period = opening['sunday'];
    }

    final now = TimeOfDay.now();

    if (period == null) {
      status = StoreStatus.closed;
    } else if (period['from']!.toMinutes < now.toMinutes &&
        period['to']!.toMinutes - 15 > now.toMinutes) {
      status = StoreStatus.open;
    } else if (period['from']!.toMinutes < now.toMinutes &&
        period['to']!.toMinutes > now.toMinutes) {
      status = StoreStatus.closing;
    } else {
      status = StoreStatus.closed;
    }
  }
}
