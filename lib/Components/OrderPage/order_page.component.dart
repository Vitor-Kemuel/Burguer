import 'package:burguer/Components/OrderPage/order_card.component.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class OrderPage extends StatefulWidget {
  final String status;

  const OrderPage({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  OrderService orderService = OrderService();
  List<OrderModel> orders = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 41, 41, 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: orderService.getOrders(widget.status),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return OrderCard(order: snapshot.data?.docs[index].data());
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
