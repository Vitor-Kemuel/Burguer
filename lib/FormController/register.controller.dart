import 'package:flutter/material.dart';

class RegisterControllerException implements Exception {
  String message;
  RegisterControllerException(this.message);
}

class RegisterControllers extends TextEditingController {
  TextEditingController? name;
  TextEditingController? email;
  TextEditingController? cellphone;
  TextEditingController? password;
  TextEditingController? confirmPassword;

  RegisterControllers() {
    _registerControllers();
  }

  _registerControllers() {
    name = TextEditingController();
    email = TextEditingController();
    cellphone = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }
}