import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lojavirtualapp/domain/models/cep_aberto_address_model.dart';

class CepService {
  static String get _token => 'f2c0b2eabaf4b62467a9511595ae7bb0';
  static String get _baseUrl => 'https://www.cepaberto.com/api/v3';

  Future<CepAbertoAddressModel?> getAddressFromCep(String cep) async {
    final String cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final String endpoint = '$_baseUrl/cep?cep=$cleanCep';

    final dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$_token';

    try {
      final result = await dio.get<Map<String, dynamic>>(endpoint);

      if (result.data == null || result.data!.isEmpty) {
        return Future.error('CEP inválido');
      }

      return CepAbertoAddressModel.fromMap(result.data!);
    } catch (e) {
      log(e.toString());

      return null;
    }
  }
}
