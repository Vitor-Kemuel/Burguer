import 'package:flutter/material.dart';

class TextButtonCustom extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;
  final double? width;
  final double? heigth;
  final EdgeInsets? margin;

  const TextButtonCustom({
    Key? key,
    required this.buttonText,
    required this.onPressed,
    this.width,
    this.heigth,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: heigth != null ? double?.parse(heigth.toString()) : 52,
        width: width != null ? double?.parse(width.toString()) : 300,
        margin: margin ?? const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15),
            backgroundColor: const Color.fromARGB(255, 223, 29, 29),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15.0),
              ),
            ),
          ),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          
        ),
      ),
    );
  }
}