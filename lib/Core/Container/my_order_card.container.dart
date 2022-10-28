import 'package:burguer/Components/Error/error.component.dart';
import 'package:burguer/Components/Loading/loading.component.dart';
import 'package:burguer/Components/MyOrderList/my_order_card_button.component.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:flutter/material.dart';

class MyOrderCardContainer extends StatefulWidget {
  final String? uid;
  const MyOrderCardContainer({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<MyOrderCardContainer> createState() => _MyOrderCardContainerState();
}

class _MyOrderCardContainerState extends State<MyOrderCardContainer> {
  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrderModel>(
      future: orderService.getOrderInformations(widget.uid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingComponent();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return MyOrderCardButton(order: snapshot.data!,);
        }

        if (snapshot.hasError) {
          return ErrorPage(
            stringError: snapshot.error.toString(),
          );
        }

        return const Center(
          child: Text("Algo deu errado"),
        );
      },
    );
  }
}
