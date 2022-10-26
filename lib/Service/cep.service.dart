import 'package:burguer/Model/cep.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CepException implements Exception {
  String message;
  CepException(this.message);
}

class CepService extends ChangeNotifier {
  Future<CepModel> searchCEP(cep) async {
    try {
      cep = cep.replaceAll(".", "");
      cep = cep.replaceAll("-", "");

      var url = Uri.https('viacep.com.br', '/ws/$cep/json/', {'q': '{http}'});
      http.Response response;

      response = await http.get(url);

      if (response.statusCode.toString() != "200") {
        return throw response.statusCode.toString();
      }

      Map<String, dynamic> resultingData = await json.decode(response.body);

      if (resultingData.containsKey('erro')) return throw "Cep não existe";

      return CepModel.fromJson(resultingData);

    } catch (e) {
      throw CepException("Erro ao buscar CEP. Server response: $e");
    }
  }
}
