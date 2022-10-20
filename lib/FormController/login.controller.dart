import 'package:flutter/material.dart';

class LoginControllerException implements Exception {
  String message;
  LoginControllerException(this.message);
}

class LoginControllers extends TextEditingController {
  TextEditingController? email;
  TextEditingController? password;

  LoginControllers() {
    _loginControllers();
  }

  _loginControllers() {
    email = TextEditingController();
    password = TextEditingController();
  }
}