import 'package:burguer/Components/OrderPage/order_page.component.dart';
import 'package:flutter/material.dart';

class OrdersWeb extends StatefulWidget {
  const OrdersWeb({super.key});

  @override
  State<OrdersWeb> createState() => _OrdersWebState();
}

class _OrdersWebState extends State<OrdersWeb> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: OrderPage(
              status: "enviado",
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: OrderPage(
              status: "aceito",
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: OrderPage(
              status: "entregue",
            ),
          ),
        ],
      ),
    );
  }
}
