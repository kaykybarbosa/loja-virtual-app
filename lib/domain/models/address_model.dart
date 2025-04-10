import 'package:equatable/equatable.dart';
import 'package:lojavirtualapp/domain/models/cep_aberto_address_model.dart';

class AddressModel extends Equatable {
  const AddressModel({
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

  final String street;
  final String? number;
  final String? complement;
  final String district;
  final String zipCode;
  final String city;
  final String state;
  final double lat;
  final double long;

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
      street: cep.street,
      district: cep.neighborhood,
      zipCode: cep.cep,
      city: cep.city.name,
      state: cep.state.acronym,
      lat: cep.latitude,
      long: cep.longitude,
    );
  }
}
