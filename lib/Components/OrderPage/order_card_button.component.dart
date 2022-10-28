import 'package:brasil_fields/brasil_fields.dart';
import 'package:burguer/Components/OrderPage/order_modal.component.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class OrderCardButton extends StatelessWidget {
  final OrderModel order;
  const OrderCardButton({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showBarModalBottomSheet(
        context: context,
        builder: (context) => OrderModal(
          order: order,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "id - ${order.id}",
                  style: const TextStyle(
                    color: Color.fromARGB(100, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("dd/MM/yy").format(order.dateOrder!),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  Text(
                    UtilBrasilFields.obterReal(
                      order.valueTotal! + order.valueDelivery!,
                    ),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  // child: Text(
                  //   "${order!["endereco"]}, ${order!["numero"]}, ${order!["bairro"]}",
                  //   style: const TextStyle(
                  //     color: Color.fromARGB(255, 0, 0, 0),
                  //   ),
                  // ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.bookmark_add_outlined,
                      color: Color.fromARGB(255, 0, 100, 0),
                    ),
                    Text(
                      DateFormat("HH:mm").format(order.dateOrder!),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 100, 0),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                order.dateOrderAccepted != null
                    ? const Expanded(
                        child: LinearProgressIndicator(
                          color: Colors.red,
                          backgroundColor: Color.fromARGB(100, 74, 44, 82),
                          value: 1,
                        ),
                      )
                    : const Expanded(
                        child: LinearProgressIndicator(
                          color: Colors.red,
                          backgroundColor: Color.fromARGB(100, 74, 44, 82),
                        ),
                      ),
                const SizedBox(
                  width: 5,
                ),
                order.dateOrderAccepted != null
                    ? Row(
                        children: [
                          const Icon(
                            Icons.verified_outlined,
                            color: Color.fromARGB(255, 0, 100, 0),
                          ),
                          Text(
                            order.dateOrderAccepted != null
                                ? DateFormat("HH:mm").format(
                                    order.dateOrderAccepted!)
                                : "xx:xx",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 100, 0),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const Icon(
                            Icons.verified_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Text(
                            order.dateOrderAccepted != null
                                ? DateFormat("HH:mm").format(
                                    order.dateOrderAccepted!)
                                : "xx:xx",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ],
                      ),
                const SizedBox(
                  width: 5,
                ),
                order.dateOrderAccepted != null
                    ? order.dateOrderSent != null
                        ? const Expanded(
                            child: LinearProgressIndicator(
                              color: Colors.red,
                              backgroundColor: Color.fromARGB(100, 74, 44, 82),
                              value: 1,
                            ),
                          )
                        : const Expanded(
                            child: LinearProgressIndicator(
                              color: Colors.red,
                              backgroundColor: Color.fromARGB(100, 74, 44, 82),
                            ),
                          )
                    : Expanded(
                        child: Container(),
                      ),
                const SizedBox(
                  width: 5,
                ),
                order.dateOrderAccepted != null
                    ? order.dateOrderSent != null
                        ? Row(
                            children: [
                              const Icon(
                                Icons.delivery_dining_outlined,
                                color: Color.fromARGB(255, 0, 100, 0),
                              ),
                              Text(
                                order.dateOrderSent != null
                                    ? DateFormat("HH:mm").format(
                                        order.dateOrderSent!)
                                    : "xx:xx",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 100, 0),
                                ),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.delivery_dining_outlined,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Text(
                                order.dateOrderSent != null
                                    ? DateFormat("HH:mm").format(
                                        order.dateOrderSent!)
                                    : "xx:xx",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              )
                            ],
                          )
                    : Row(
                        children: [
                          const Icon(
                            Icons.delivery_dining_outlined,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          Text(
                            order.dateOrderSent != null
                                ? DateFormat("HH:mm")
                                    .format(order.dateOrderSent!)
                                : "xx:xx",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          )
                        ],
                      ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
