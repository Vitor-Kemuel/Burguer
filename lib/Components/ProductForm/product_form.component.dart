import 'package:burguer/Components/Buttons/elevated_button_custom.component.dart';
import 'package:burguer/Components/Dropdown/dropdown_custom.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/Model/product.model.dart';
import 'package:burguer/Service/product.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';

class ProductForm extends StatefulWidget {
  final ProductModel? model;
  const ProductForm({
    Key? key,
    this.model,
  }) : super(key: key);

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> categories = ["Lanche", "Sobremesa", "Bebida"];
  final List<String> status = ["Ativo", "Inativo"];

  String? dropDownCategory;
  String? dropDownStatus;

  String productName = '';
  String productPrice = '';

  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerProductPrice = TextEditingController();
  final TextEditingController _controllerProductNote = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      setState(() {
        dropDownCategory = widget.model!.category!;
        _controllerProductName.text = widget.model!.name!;
        dropDownStatus = widget.model!.status!;
        _controllerProductPrice.text =
            widget.model!.price!.toStringAsFixed(2).replaceAll(".", ",");
        _controllerProductNote.text = widget.model!.note!;
      });
    }
  }

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ProductModel product = ProductModel(
        category: dropDownCategory,
        name: _controllerProductName.text,
        status: dropDownStatus,
        price: double.parse(_controllerProductPrice.text.replaceAll(",", ".")),
        note: _controllerProductNote.text,
        uid: widget.model == null ? null : widget.model!.uid,
      );
      if (widget.model == null) {
        ProductService().registration(product, context);
      } else {
        ProductService().update(product, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 0, 0, 0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Text(
              widget.model == null ? "Novo produto" : "Editar produto",
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
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 41, 41, 41),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormInputCustom(
                          onSaved: (value) => productName = value!,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo nome é obrigatorio!";
                            }
                            return null;
                          },
                          controller: _controllerProductName,
                          labelText: "Nome do Produto",
                          placeholder: "Creme de avelã",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropDownCustom(
                          labelText: "Selecione a categoria do produto",
                          value: dropDownCategory,
                          onChanged: (Object? categories) {
                            setState(() {
                              dropDownCategory = categories!.toString();
                            });
                          },
                          items: categories,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        DropDownCustom(
                          labelText: "Selecione o status do produto",
                          value: dropDownStatus,
                          onChanged: (Object? categories) {
                            setState(() {
                              dropDownStatus = categories!.toString();
                            });
                          },
                          items: status,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormInputCustom(
                          prefixIcon: Icons.attach_money_rounded,
                          inputType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CentavosInputFormatter(),
                          ],
                          controller: _controllerProductPrice,
                          labelText: "Preço",
                          placeholder: "15,00",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo nome é obrigatorio!";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormInputCustom(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Campo observações é obrigatorio!";
                            }
                            return null;
                          },
                          controller: _controllerProductNote,
                          labelText: "Observações",
                          placeholder:
                              "Pão de hamburguer, alface, hamburguer bovino...",
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButtonCustom(
                          textButton: "Cadastrar",
                          onPressed: () => save(context),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
