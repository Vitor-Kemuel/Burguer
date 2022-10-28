import 'package:brasil_fields/brasil_fields.dart';
import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/RenderItemsModal/render_items_modal.component.dart';
import 'package:burguer/Enum/type_payment.enum.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class OrderModal extends StatefulWidget {
  final OrderModel order;
  const OrderModal({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<OrderModal> createState() => _OrderModalState();
}

class _OrderModalState extends State<OrderModal> {
  String? reasonDenied;

  @override
  Widget build(BuildContext context) {
    OrderService orderService = OrderService();
    TextEditingController _controllerReasonDenied = TextEditingController();
    return Container(
      color: Color.fromARGB(255, 41, 41, 41),
      child: Container(
          margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Id - ${widget.order.id}",
                      style: TextStyle(
                        color: Color.fromARGB(176, 255, 255, 255),
                      ),
                    ),
                    Text(
                      DateFormat("dd/MM/yy").format(widget.order.dateOrder!),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  "${widget.order.userName}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Text(
                  "${widget.order.userCellPhone}",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                child: Card(
                    child: widget.order.dateOrderSent != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.check_circle),
                              Text(
                                "Pedido concluido as ${DateFormat("HH:mm").format(widget.order.dateOrderSent!)}",
                              ),
                            ],
                          )
                        : widget.order.dateOrderAccepted != null
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.check_rounded),
                                  Text(
                                    "Pedido aceito as ${DateFormat("HH:mm").format(widget.order.dateOrderAccepted!)}",
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.airplane_ticket_outlined),
                                  Text(
                                    "Pedido enviado as ${DateFormat("HH:mm").format(widget.order.dateOrder!)}",
                                  )
                                ],
                              )),
              ),
              const Divider(
                color: Color.fromARGB(255, 255, 255, 255),
                endIndent: 20,
                thickness: 1,
                height: 10,
                indent: 20,
              ),
              RenderItemsModal(items: widget.order.items ?? []),
              const Divider(
                color: Color.fromARGB(255, 255, 255, 255),
                endIndent: 20,
                thickness: 1,
                height: 10,
                indent: 20,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "SubTotal",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      UtilBrasilFields.obterReal(
                        widget.order.valueTotal!,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Taxa de Entrega",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      UtilBrasilFields.obterReal(
                        widget.order.valueDelivery!,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      UtilBrasilFields.obterReal(
                        widget.order.valueTotal! + widget.order.valueDelivery!,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 255, 255, 255),
                endIndent: 20,
                thickness: 1,
                height: 10,
                indent: 20,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pagamento no ${widget.order.typePayment! == TypePayment.money ? 'Dinheiro' : 'Cartão'}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    widget.order.typePayment == "Dinheiro"
                        ? Text(
                            "R\$ ${(double.parse(widget.order.moneyChange!.replaceAll(",", ".")) - widget.order.valueTotal!)}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.credit_card_rounded,
                                color: Colors.white,
                              ),
                              Text(
                                "${widget.order.cardFlag}",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                  ],
                ),
              ),
              const Divider(
                color: Color.fromARGB(255, 255, 255, 255),
                endIndent: 20,
                thickness: 1,
                height: 10,
                indent: 20,
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: ListTile(
                  leading: const Icon(
                    Icons.house_sharp,
                    color: Colors.white,
                    size: 32.0,
                  ),
                  title: Text(
                    "${widget.order.address!.publicPlace}, ${widget.order.address!.number}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  subtitle: Text(
                    "${widget.order.address!.district} - ${widget.order.address!.city}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                child: widget.order.status == "enviado"
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButtonCustom(
                            buttonText: "Recusar",
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  // ignore: prefer_const_constructors
                                  title: Center(
                                    child: Text(
                                      "Motivo de recuso",
                                      style: TextStyle(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  // ignore: prefer_const_constructors
                                  content: TextField(
                                    controller: _controllerReasonDenied,
                                    //autofocus: true,
                                    cursorRadius: Radius.circular(15),
                                    autocorrect:
                                        true, // auto correção de palavras
                                    maxLines: 7,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2,
                                            color: Colors.red,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      hintText:
                                          "Cancelado por falta de morango em nosso estoque",
                                      labelText: "Digite o motivo de recuso",
                                      labelStyle: TextStyle(
                                        color: Colors.red,
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 2,
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),

                                  actions: [
                                    TextButtonCustom(
                                      buttonText: "Enviar",
                                      onPressed: () {
                                        orderService.rejectOrder(
                                            widget.order.id!,
                                            _controllerReasonDenied.text,
                                            context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                            width: MediaQuery.of(context).size.width / 3,
                          ),
                          TextButtonCustom(
                            buttonText: "Aceitar",
                            onPressed: () {
                              orderService.acceptOrder(
                                  widget.order.id!, context);
                            },
                            width: MediaQuery.of(context).size.width / 3,
                          )
                        ],
                      )
                    : widget.order.status == "aceito"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Entregar",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    "Altere o Status",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                              TextButtonCustom(
                                onPressed: () {
                                  orderService.finishOrder(
                                    widget.order.id!,
                                    context,
                                  );
                                },
                                buttonText: "OK",
                                heigth: 50,
                                width: 80,
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Pedido encerrado",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
              )
            ],
          )),
    ); // ignore: dead_code
  }
}
