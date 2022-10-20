import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    Key? key,
    required this.stringError,
  }) : super(key: key);
  final String stringError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 109, 109, 109),
      appBar: AppBarCustom(
        title: "Error",
        context: context,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.red,
              style: BorderStyle.solid,
              width: 2,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          child: Text(
            stringError,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}