import 'package:burguer/Components/MyOrderList/card_my_order.component.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyOrderList extends StatefulWidget {
  const MyOrderList({
    Key? key,
  }) : super(key: key);

  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> {
  final OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 41, 41, 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: orderService.getMyOrders(),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return CardMyOrder(order: snapshot.data?.docs[index].data());
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