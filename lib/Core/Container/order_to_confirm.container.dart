import 'package:burguer/Components/Error/error.component.dart';
import 'package:burguer/Components/LoadingPage/loading_page.component.dart';
import 'package:burguer/Model/order_to_confirm.model.dart';
import 'package:burguer/Service/order.service.dart';
import 'package:burguer/View/ConfirmOrder/confirm_order.view.dart';
import 'package:flutter/material.dart';

class OrderToConfirmContainer extends StatefulWidget {
  const OrderToConfirmContainer({Key? key}) : super(key: key);

  @override
  State<OrderToConfirmContainer> createState() => _OrderToConfirmContainerState();
}

class _OrderToConfirmContainerState extends State<OrderToConfirmContainer> {
  OrderService orderService = OrderService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OrderToConfirm>(
      future: orderService.getInformationsToSubmit(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
            return ConfirmOrder(orderToConfirm: snapshot.data!);
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
