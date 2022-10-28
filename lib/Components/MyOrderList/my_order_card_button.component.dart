import 'package:brasil_fields/brasil_fields.dart';
import 'package:burguer/Components/MyOrderList/my_order_modal.component.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:intl/intl.dart';

class MyOrderCardButton extends StatelessWidget {
  final OrderModel order;
  const MyOrderCardButton({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showBarModalBottomSheet(
        context: context,
        builder: (context) => MyOrderModal(
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
                    color: Color.fromARGB(99, 255, 255, 255),
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
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  Text(
                    UtilBrasilFields.obterReal(
                      order.valueTotal! + order.valueDelivery!,
                    ),
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: Text(
                    "${order.address!.publicPlace}, ${order.address!.number}, ${order.address!.district}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
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
                      color: Color.fromARGB(255, 0, 248, 0),
                    ),
                    Text(
                      DateFormat("HH:mm").format(order.dateOrder!),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 248, 0),
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
                          backgroundColor: Color.fromARGB(101, 244, 67, 54),
                          value: 1,
                        ),
                      )
                    : const Expanded(
                        child: LinearProgressIndicator(
                          color: Colors.red,
                          backgroundColor: Color.fromARGB(101, 244, 67, 54),
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
                            color: Color.fromARGB(255, 0, 248, 0),
                          ),
                          Text(
                            order.dateOrderAccepted != null
                                ? DateFormat("HH:mm").format(
                                    order.dateOrderAccepted!)
                                : "xx:xx",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 0, 248, 0),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          const Icon(
                            Icons.verified_outlined,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          Text(
                            order.dateOrderAccepted != null
                                ? DateFormat("HH:mm").format(
                                    order.dateOrderAccepted!)
                                : "xx:xx",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
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
                              backgroundColor: Color.fromARGB(101, 244, 67, 54),
                              value: 1,
                            ),
                          )
                        : const Expanded(
                            child: LinearProgressIndicator(
                              color: Colors.red,
                              backgroundColor: Color.fromARGB(101, 244, 67, 54),
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
                                color: Color.fromARGB(255, 0, 248, 0),
                              ),
                              Text(
                                order.dateOrderSent != null
                                    ? DateFormat("HH:mm").format(
                                        order.dateOrderSent!)
                                    : "xx:xx",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 0, 248, 0) ,
                                ),
                              )
                            ],
                          )
                        : Row(
                            children: [
                              const Icon(
                                Icons.delivery_dining_outlined,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                              Text(
                                order.dateOrderSent != null
                                    ? DateFormat("HH:mm").format(
                                        order.dateOrderSent!)
                                    : "xx:xx",
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              )
                            ],
                          )
                    : Row(
                        children: [
                          const Icon(
                            Icons.delivery_dining_outlined,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          Text(
                            order.dateOrderSent != null
                                ? DateFormat("HH:mm")
                                    .format(order.dateOrderSent!)
                                : "xx:xx",
                            style: const TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
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
