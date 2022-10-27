import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/FormController/address.controller.dart';
import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Model/cep.model.dart';
import 'package:burguer/Service/address.service.dart';
import 'package:burguer/Service/cep.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';

class NewAddress extends StatefulWidget {
  const NewAddress({Key? key}) : super(key: key);

  @override
  State<NewAddress> createState() => _NewAddress();
}

class _NewAddress extends State<NewAddress> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AddressControllerService controller = AddressControllerService();

  bool enableStreet = false;
  bool enableNumber = false;
  bool enableComplement = false;
  bool enableDistrict = false;
  bool enableCity = false;
  bool enableName = false;
  String cepSearched = "";

  bool isLoading = false;
  bool registerIsLoading = false;

  void save(BuildContext context) async {
    if (cepSearched.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("É necessário buscar por um CEP primeiro"),
        ),
      );
    } else if (cepSearched == controller.cep!.text) {
      if (formKey.currentState!.validate()) {
        try {
          setState(() => registerIsLoading = true);
          AddressModel model = AddressModel(
            district: controller.district!.text,
            zipCode: controller.cep!.text,
            city: controller.city!.text,
            complement: controller.complement!.text,
            publicPlace: controller.street!.text,
            name: controller.name!.text,
            number: controller.number!.text,
            uid: null,
          );
          AddressService().registration(model, context);
        } on AddressException catch (e) {
          setState(() => registerIsLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.message)),
          );
        }
      } else {
        setState(() => registerIsLoading = false);
      }
    }
  }

  searchCEP() async {
    setState(() => isLoading = true);
    cepSearched = controller.cep!.text;
    var cepService = CepService();
    try {
      CepModel? result;
      await cepService.searchCEP(cepSearched).then((value) {
        setState(() {
          result = value;
        });
      });
      controller.setValue(result!);

      setState(() {
        enableNumber = true;
        enableName = true;
        enableCity = controller.city!.text != "" ? false : true;
        enableComplement = controller.complement!.text != "" ? false : true;
        enableDistrict = controller.district!.text != "" ? false : true;
        enableStreet = controller.street!.text != "" ? false : true;
        isLoading = false;
      });
    } on CepException catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message),
        ),
      );
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
            child: const Text(
              "Novo endereço",
              style: TextStyle(
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
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextFormInputCustom(
                            controller: controller.cep,
                            labelText: "CEP",
                            placeholder: "Ex 15200000",
                            inputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              CepInputFormatter(),
                            ],
                          ),
                        ),
                        (isLoading)
                            ? const SizedBox(
                                height: 50,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            : TextButtonCustom(
                                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                buttonText: "Buscar",
                                onPressed: searchCEP,
                                width: MediaQuery.of(context).size.width / 4,
                                heigth: 50,
                              ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormInputCustom(
                      controller: controller.name,
                      labelText: 'Nome do endereço',
                      placeholder: 'Ex. Trabalho',
                      enable: enableName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "De um nome para o endereço";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormInputCustom(
                      controller: controller.street,
                      labelText: 'Logradouro',
                      placeholder: 'Rua José Pereira',
                      enable: enableStreet,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite seu logradouro";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormInputCustom(
                      controller: controller.number,
                      labelText: 'Numero',
                      placeholder: '547',
                      inputType: TextInputType.number,
                      enable: enableNumber,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite o número da sua casa";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormInputCustom(
                      controller: controller.complement,
                      labelText: 'Complemento',
                      placeholder: 'Apartamento 13',
                      enable: enableComplement,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite um complemento";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormInputCustom(
                      controller: controller.district,
                      labelText: 'Bairro',
                      placeholder: 'Jardim das Flores',
                      enable: enableDistrict,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite o bairro onde reside";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormInputCustom(
                      controller: controller.city,
                      labelText: 'Cidade',
                      placeholder: 'São José do Rio Preto',
                      enable: enableCity,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Digite sua cidade";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    (registerIsLoading)
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          )
                        : TextButtonCustom(
                            buttonText: "Cadastrar",
                            onPressed: () => save(context),
                          ),
                    const SizedBox(
                      height: 30,
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
