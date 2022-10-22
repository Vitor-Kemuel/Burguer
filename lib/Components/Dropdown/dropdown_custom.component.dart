import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDownCustom extends StatelessWidget {
  final String? labelText;
  final String? value;
  final void Function(Object?) onChanged;
  final List<String>? items;

  const DropDownCustom({
    Key? key,
    required this.labelText,
    required this.value,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        dropdownOverButton: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                labelText!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: items!
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        value: value,
        onChanged: onChanged,
        icon: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
        iconSize: 14,
        iconEnabledColor: Color.fromARGB(255, 255, 255, 255),
        buttonHeight: 50,
        buttonPadding: const EdgeInsets.only(left: 14, right: 14),
        buttonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            width: 2,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
          color: Color.fromARGB(0, 0, 0, 0),
        ),
        buttonElevation: 2,
        itemHeight: 40,
        itemPadding: const EdgeInsets.only(left: 14, right: 14),
        dropdownMaxHeight: 200,
        dropdownPadding: null,
        dropdownDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        dropdownElevation: 8,
        scrollbarRadius: const Radius.circular(10),
        scrollbarThickness: 6,
        scrollbarAlwaysShow: true,
      ),
    );
  }
}
