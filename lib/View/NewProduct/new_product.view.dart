import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/Buttons/elevated_button_custom.component.dart';
import 'package:burguer/Components/Dropdown/dropdown_custom.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/Model/product.model.dart';
import 'package:burguer/Service/product.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:brasil_fields/brasil_fields.dart';

class NewProduct extends StatefulWidget {
  const NewProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<NewProduct> createState() => _NewProductState();
}

class _NewProductState extends State<NewProduct> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? dropDownCategory;
  String? dropDownStatus;
  String? dropDownType;

  String productName = '';
  String productPrice = '';

  final TextEditingController _controllerProductName = TextEditingController();
  final TextEditingController _controllerProductPrice = TextEditingController();
  final TextEditingController _controller = TextEditingController();

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      ProductModel model = ProductModel(
        category: dropDownCategory,
        name: _controllerProductName.text,
        status: dropDownStatus,
        uid: null,
      );

      ProductService().registration(model, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(
        title: "Novo Produto",
        context: context,
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
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
                    // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
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
                  ElevatedButtonCustom(
                    textButton: "Cadastrar",
                    onPressed: () => save(context),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> categories = [
    "Lanche",
    "Sobremesa",
    "Bebida",
  ];

  List<String> status = [
    "Ativo",
    "Inativo",
  ];
}
