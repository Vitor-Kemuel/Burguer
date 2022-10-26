import 'package:burguer/Model/cep.model.dart';
import 'package:flutter/material.dart';

class ControllerAddressException implements Exception {
  String message;
  ControllerAddressException(this.message);
}

class AddressControllerService extends TextEditingController {
  String? page;
  TextEditingController? cep;
  TextEditingController? city;
  TextEditingController? complement;
  TextEditingController? district;
  TextEditingController? name;
  TextEditingController? number;
  TextEditingController? street;

  AddressControllerService() {
    _addressControllerService();
  }

  _addressControllerService() {
    cep = TextEditingController();
    city = TextEditingController();
    complement = TextEditingController();
    district = TextEditingController();
    name = TextEditingController();
    number = TextEditingController();
    street = TextEditingController();
  }

  setValue(CepModel result) {
    if (result.logradouro != "") {
      street = TextEditingController(text: result.logradouro);
    } else {
      street = TextEditingController(text: "");
    }

    if (result.complemento != "") {
      complement = TextEditingController(text: result.complemento);
    } else {
      complement = TextEditingController(text: "");
    }

    if (result.bairro != "") {
      district = TextEditingController(text: result.bairro);
    } else {
      district = TextEditingController(text: "");
    }

    if (result.localidade != "") {
      city = TextEditingController(text: result.localidade);
    } else {
      city = TextEditingController(text: "");
    }
  }
}