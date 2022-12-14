import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormInputCustom extends StatefulWidget {
  final String? labelText;
  final IconData? prefixIcon;
  final bool? isTextInputSecret;
  final TextInputType? inputType;
  final bool? obscureText;
  final FormFieldSetter<String>? onSaved;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final List<TextInputFormatter>? inputFormatters;
  final String? placeholder;
  final bool? enable;

  const TextFormInputCustom({
    Key? key,
    required this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.isTextInputSecret = false,
    this.onSaved,
    this.enable = true,
    this.controller,
    this.validator,
    this.placeholder,
    this.inputType,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<TextFormInputCustom> createState() => _TextFormInputCustomState();
}

class _TextFormInputCustomState extends State<TextFormInputCustom> {
  bool obscureText = false;
  bool isTextInputSecret = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obscureText = widget.obscureText!;
    isTextInputSecret = widget.isTextInputSecret!;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enable,
      onSaved: widget.onSaved,
      controller: widget.controller,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.inputType ?? TextInputType.text,
      validator: widget.validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        hintText: widget.placeholder ?? '',
        hintStyle: TextStyle(
          color: Color.fromARGB(106, 255, 255, 255),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 255, 255),
            width: 2,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(234, 255, 255, 255),
            width: 2,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        labelText: widget.labelText,
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 30.0,
          color: Colors.white,
        ),
        suffixIcon: isTextInputSecret
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                child: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
              )
            : null,
        errorStyle: const TextStyle(fontSize: 16.0),
      ),
      style: const TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    );
  }
}
