import 'package:flutter/material.dart';

class DropdownFormFielCustom extends StatelessWidget {
  final String? labelText;
  final Object? value;
  final void Function(Object?) onChanged;
  final List<DropdownMenuItem<Object>>? items;
  final String? Function(Object?)? validator;

  const DropdownFormFielCustom({
    Key? key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DropdownButtonFormField(
          dropdownColor: Color.fromARGB(255, 0, 0, 0),
          decoration: InputDecoration(
            floatingLabelStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            labelStyle: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            labelText: labelText,
            hintText: labelText,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 255, 255, 255),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 240, 0, 0),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 255, 255, 255),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(255, 255, 255, 255),
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          itemHeight: 70,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          borderRadius: BorderRadius.circular(20),
          value: value,
          hint: Text(
            labelText!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(136, 255, 255, 255),
            ),
          ),
          elevation: 8,
          onChanged: onChanged,
          items: items,
          validator: validator,
        ),
      ),
    );
  }
}
