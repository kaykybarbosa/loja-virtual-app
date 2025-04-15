import 'package:equatable/equatable.dart';

class CepAbertoAddressModel extends Equatable {
  const CepAbertoAddressModel({
    this.altitude,
    this.latitude,
    this.longitude,
    required this.cep,
    this.street,
    this.neighborhood,
    required this.city,
    required this.state,
  });

  final double? altitude;
  final double? latitude;
  final double? longitude;
  final String cep;

  /// Logradouro
  final String? street;

  /// Bairro
  final String? neighborhood;

  final CityModel city;
  final StateModel state;

  @override
  List<Object?> get props => [
        altitude,
        latitude,
        longitude,
        cep,
        street,
        neighborhood,
        city,
        state,
      ];

  factory CepAbertoAddressModel.fromMap(Map<String, dynamic> map) => CepAbertoAddressModel(
        altitude: map['altitude'],
        latitude: double.parse(map['latitude']),
        longitude: double.parse(map['longitude']),
        cep: map['cep'],
        street: map['logradouro'] ?? '',
        neighborhood: map['bairro'] ?? '',
        city: CityModel.fromMap(map['cidade']),
        state: StateModel.fromMap(map['estado']),
      );
}

class CityModel extends Equatable {
  const CityModel({
    this.ddd,
    this.name,
  });

  final int? ddd;
  final String? name;

  factory CityModel.fromMap(Map<String, dynamic> map) => CityModel(
        ddd: map['ddd'],
        name: map['nome'],
      );

  @override
  List<Object?> get props => [ddd, name];
}

class StateModel extends Equatable {
  const StateModel({this.acronym});

  final String? acronym;

  factory StateModel.fromMap(Map<String, dynamic> map) => StateModel(acronym: map['sigla']);

  @override
  List<Object?> get props => [acronym];
}
