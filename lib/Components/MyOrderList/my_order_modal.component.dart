import 'package:brasil_fields/brasil_fields.dart';
import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/RenderItemsModal/render_items_modal.component.dart';
import 'package:burguer/Enum/type_payment.enum.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class MyOrderModal extends StatefulWidget {
  final OrderModel order;
  const MyOrderModal({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  State<MyOrderModal> createState() => _MyOrderModalState();
}

class _MyOrderModalState extends State<MyOrderModal> {
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
            ],
          )),
    ); // ignore: dead_code
  }
}
