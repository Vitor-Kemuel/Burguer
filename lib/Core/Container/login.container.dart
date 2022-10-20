import 'package:burguer/Core/Container/user.container.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:burguer/View/Home/home.view.dart';
import 'package:flutter/material.dart';
import 'package:burguer/View/Login/login.view.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({Key? key}) : super(key: key);

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  AuthenticationService auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    if (auth.userIsLogaded() != null){
      return UserContainer();
    } else {
      return LoginView();
    }
  }
}