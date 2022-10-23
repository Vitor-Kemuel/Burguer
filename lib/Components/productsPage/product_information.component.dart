import 'package:burguer/Components/Buttons/elevated_button_custom.component.dart';
import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/Model/product.model.dart';
import 'package:flutter/material.dart';

class ProductInformation extends StatefulWidget {
  final ProductModel product;
  const ProductInformation({super.key, required this.product});

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  int _itemAmount = 1;

  void _incrementItemAmount() {
    setState(() {
      _itemAmount++;
    });
  }

  void _decrementItemAmount() {
    setState(() {
      _itemAmount > 1 ? _itemAmount-- : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 41, 41, 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Text(
              widget.product.name!,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Color.fromARGB(255, 240, 240, 240),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 12, 12, 12),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Column(children: [
                Container(
                  margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
                  child: TextFormInputCustom(labelText: "Observações"),
                ),
              ]),
            ),
          ),
          Container(
            color: Color.fromARGB(255, 12, 12, 12),
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(7, 7, 0, 7),
                      child: TextButtonCustom(
                        buttonText: "-",
                        onPressed: _decrementItemAmount,
                        heigth: 52,
                        width: 52,
                      ),
                    ),
                    Container(
                      color: const Color.fromARGB(255, 200, 200, 200),
                      padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
                      height: 66,
                      width: 52,
                      child: Center(
                        child: Text(
                          _itemAmount.toString(),
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 200, 200, 200),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      padding: const EdgeInsets.fromLTRB(0, 7, 7, 7),
                      child: TextButtonCustom(
                        buttonText: "+",
                        onPressed: _incrementItemAmount,
                        heigth: 52,
                        width: 52,
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: ElevatedButtonCustom(
                    textButton: "Adicionar",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
