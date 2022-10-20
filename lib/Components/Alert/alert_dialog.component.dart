import 'package:flutter/material.dart';

AlertDialog showAlertDialog(BuildContext context, String message) =>
    AlertDialog(
      title: Text(
        'Atenção',
        style: TextStyle(fontSize: 22.0),
      ),
      content: Text(
        message,
        style: TextStyle(fontSize: 22.0),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
      ],
    );
