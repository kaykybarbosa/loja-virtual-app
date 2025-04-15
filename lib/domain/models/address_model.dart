import 'package:equatable/equatable.dart';
import 'package:lojavirtualapp/domain/models/cep_aberto_address_model.dart';

// ignore: must_be_immutable
class AddressModel extends Equatable {
  AddressModel({
    required this.street,
    this.number,
    this.complement,
    required this.district,
    required this.zipCode,
    required this.city,
    required this.state,
    required this.lat,
    required this.long,
  });

  String street;
  String? number;
  String? complement;
  String district;
  String zipCode;
  String city;
  String state;
  double lat;
  double long;

  @override
  List<Object?> get props => [
        street,
        number,
        complement,
        district,
        zipCode,
        city,
        state,
      ];

  factory AddressModel.fromCepAbertoAddress(CepAbertoAddressModel cep) {
    return AddressModel(
      street: cep.street ?? '',
      district: cep.neighborhood ?? '',
      zipCode: cep.cep,
      city: cep.city.name ?? '',
      state: cep.state.acronym ?? '',
      lat: cep.latitude ?? 0.0,
      long: cep.longitude ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() => {
        'street': street,
        'number': number,
        'complement': complement,
        'district': district,
        'zipCode': zipCode,
        'city': city,
        'state': state,
        'lat': lat,
        'long': long,
      };

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      street: map['street'],
      number: map['number'],
      complement: map['complement'],
      district: map['district'],
      zipCode: map['zipCode'],
      city: map['city'],
      state: map['state'],
      lat: map['lat'],
      long: map['long'],
    );
  }
}
