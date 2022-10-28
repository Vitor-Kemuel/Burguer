import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/MyOrderList/my_order_list.component.dart';
import 'package:flutter/material.dart';


class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      appBar: AppBarCustom(
        title: "Meus Pedidos",
        context: context,
      ),
      body: MyOrderList(),
    );
  }
}