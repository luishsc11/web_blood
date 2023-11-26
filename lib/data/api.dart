import 'dart:convert';

import 'package:dio/dio.dart';

class Api {
  final headers = {
    'x-hasura-admin-secret':
        '0HjelTUUda4ATK12IpuD0ptO3mIMO9YGJ5N73VpQwMLOyaSJ8ge4hVOICPXHeOWW',
    'content-type': 'application/json'
  };
  final dio = Dio();

  Future<List<dynamic>> getCadastro() async {
    dio.options.headers = headers;
    final result = await dio
        .get('https://coherent-elephant-41.hasura.app/api/rest/cadastroget');
    return result.data['cadastro'];
  }

  Future<void> postCadastro({
    required String nome,
    required String telefone,
    required String tipagem,
    required String sangue,
    required String datanasc,
    required String peso,
  }) async {
    dio.options.headers = headers;
    final body = {
      "nome": nome,
      "telefone": telefone,
      "tipagem": tipagem,
      "sangue": sangue,
      "datanasc": datanasc,
      "peso": peso,
    };
    try {
      await dio.post(
          'https://coherent-elephant-41.hasura.app/api/rest/cadastropost',
          data: json.encode(body));
    } catch (e) {}
  }
}
