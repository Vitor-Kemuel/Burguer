import 'package:burguer/Components/Error/error.component.dart';
import 'package:burguer/Components/Loading/loading.component.dart';
import 'package:burguer/Components/OrderPage/order_card_button.component.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:flutter/material.dart';

class OrderCardContainer extends StatefulWidget {
  final String? uid;
  const OrderCardContainer({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<OrderCardContainer> createState() => _OrderCardContainerState();
}

class _OrderCardContainerState extends State<OrderCardContainer> {
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
          return OrderCardButton(order: snapshot.data!,);
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
