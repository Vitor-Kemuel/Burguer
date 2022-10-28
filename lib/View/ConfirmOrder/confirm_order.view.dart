import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/Dropdown/dropdownFormFieldCustom.component.dart';
import 'package:burguer/Components/AddressForm/address_form.component.dart';
import 'package:burguer/Components/RadioButton/radio_button.component.dart';
import 'package:burguer/Components/TextForm/text_form_custom.component.dart';
import 'package:burguer/Components/ValueOrder/InformationValueOrder.component.dart';
import 'package:burguer/Enum/type_payment.enum.dart';
import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Model/order_to_confirm.model.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:burguer/Service/order_validator.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ConfirmOrder extends StatefulWidget {
  final OrderToConfirm orderToConfirm;
  const ConfirmOrder({
    Key? key,
    required this.orderToConfirm,
  }) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  final GlobalKey<FormState> formMainKey = GlobalKey<FormState>();
  final AuthenticationService auth = AuthenticationService();
  TextEditingController moneyController = TextEditingController();
  AddressModel? addressSelected;
  TypePayment _typePayment = TypePayment.money;
  String? cardFlagSelected;
  String? cardPaymentSelected;
  bool isLoading = false;

  onChangeRadioButton(TypePayment value) => setState(() {
        _typePayment = value;
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 41, 41, 41),
      appBar: AppBarCustom(
        title: 'Pagamento',
        context: context,
      ),
      body: Form(
        key: formMainKey,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 24.0, 8.0, 24.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width,
                child: InformationValueOrder(
                  valueTotal: widget.orderToConfirm.valueTotal,
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Column(
              children: [
                DropdownFormFielCustom(
                  labelText: "Selecione o endereço de entrega",
                  value: addressSelected,
                  onChanged: (value) {
                    setState(() {
                      addressSelected = value as AddressModel;
                    });
                  },
                  items:
                      widget.orderToConfirm.address!.map((AddressModel item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(
                        '${item.publicPlace}, ${item.number}',
                        style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'O endereço de entrega é obrigatório';
                    }

                    return null;
                  },
                ),
                TextButton(
                  child: const Text('Cadastrar endereço',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.0,
                      )),
                  onPressed: () {
                    showBarModalBottomSheet(
                      context: context,
                      builder: (context) => AddressForm(),
                    );
                  },
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
              child: Center(
                child: Text(
                  "Selecione a forma de pagamento",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RadioButton(
                  textRadioButton: 'Dinheiro',
                  groupValue: _typePayment,
                  value: TypePayment.money,
                  onChanged: (value) => onChangeRadioButton(value),
                ),
                RadioButton(
                  textRadioButton: 'Cartão',
                  groupValue: _typePayment,
                  value: TypePayment.cardCredit,
                  onChanged: (value) => onChangeRadioButton(value),
                ),
              ],
            ),
            if (_typePayment == TypePayment.money)
              Center(
                child: TextFormInputCustom(
                  controller: moneyController,
                  labelText: 'Troco',
                  inputType: TextInputType.number,
                  prefixIcon: Icons.attach_money_rounded,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    CentavosInputFormatter(),
                  ],
                  validator: (value) => OrderValidator.validarTroco(
                      value!, widget.orderToConfirm.valueTotal!),
                  onSaved: (_) {
                    cardFlagSelected = '';
                    cardPaymentSelected = '';
                  },
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    DropdownFormFielCustom(
                      labelText: "Selecione a bandeira do cartão",
                      value: cardFlagSelected,
                      onChanged: (value) {
                        setState(() {
                          cardFlagSelected = value.toString();
                          moneyController.clear();
                        });
                      },
                      items: typeCardPayment.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'A bandeira do cartão é obrigatório';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    DropdownFormFielCustom(
                      labelText: "Selecione a forma de pagamento",
                      value: cardPaymentSelected,
                      onChanged: (value) {
                        setState(() {
                          cardPaymentSelected = value.toString();
                        });
                      },
                      items: typePayment.map((String item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'A bandeira do cartão é obrigatório';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            TextButtonCustom(
              buttonText: 'Finalizar Pedido',
              onPressed: () {
                if (formMainKey.currentState!.validate()) {
                  formMainKey.currentState!.save();

                  setState(() {
                    isLoading = true;
                  });

                  OrderModel model = OrderModel(
                    address: addressSelected,
                    dateOrder: DateTime.now(),
                    userEmail: auth.userIsLogaded().email,
                    userName: widget.orderToConfirm.user!.name,
                    userCellPhone: widget.orderToConfirm.user!.cellphone,
                    valueTotal: widget.orderToConfirm.valueTotal,
                    valueDelivery: widget.orderToConfirm.valueDelivery,
                    typePayment: _typePayment,
                    moneyChange: moneyController.text,
                    cardFlag: cardFlagSelected,
                    cardPayment: cardPaymentSelected,
                    itens: widget.orderToConfirm.itens,
                  );

                  OrderService().save(model, context);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

List<String> typeCardPayment = ["Visa", "MasterCard"];
List<String> typePayment = ["Crédito", "Débito"];
