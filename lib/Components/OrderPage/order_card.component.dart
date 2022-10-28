import 'package:brasil_fields/brasil_fields.dart';
import 'package:burguer/Components/OrderPage/order_modal.component.dart';
import 'package:burguer/Core/Container/order_card.container.dart';
import 'package:flutter/material.dart';

import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class OrderCard extends StatelessWidget {
  final Map? order;

  const OrderCard({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 240, 240, 240),
      child: Column(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(25, 10, 10, 10),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  width: 3,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  style: BorderStyle.solid,
                ),
              ),
              width: MediaQuery.of(context).size.width,
              child: OrderCardContainer(
                uid: order!["uid"],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
