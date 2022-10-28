import 'package:burguer/Core/Container/my_order_card.container.dart';
import 'package:flutter/material.dart';

class CardMyOrder extends StatelessWidget {
  final Map? order;

  const CardMyOrder({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(25, 10, 10, 10),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3),
                ),
              ],
              color: Color.fromARGB(255, 114, 114, 114),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            width: MediaQuery.of(context).size.width,
            child: MyOrderCardContainer(
              uid: order!["uid"],
            ),
          ),
        ),
      ],
    );
  }
}
