import 'package:burguer/Components/Cart/cart_page.component.dart';
import 'package:burguer/Components/Error/error.component.dart';
import 'package:burguer/Components/LoadingPage/loading_page.component.dart';
import 'package:burguer/Model/cart.model.dart';
import 'package:burguer/Service/cart.service.dart';
import 'package:flutter/material.dart';

class CartContainer extends StatefulWidget {
  const CartContainer({Key? key}) : super(key: key);

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  CartService cart = CartService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CartModel>(
      future: cart.getCart(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingPage();
        }

        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
            return CartPage(cart: snapshot.data!,);
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
