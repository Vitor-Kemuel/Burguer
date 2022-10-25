import 'package:burguer/Components/Cart/card_item.component.dart';
import 'package:burguer/Model/cart_item.model.dart';
import 'package:flutter/material.dart';


class CartList extends StatelessWidget {
  final List<CartItemModel> cartItens;

  const CartList({
    Key? key,
    required this.cartItens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        itemCount: cartItens.length,
        itemBuilder: (_, index) {
          return CartProduct(
            cartItem: cartItens[index],
            index: index,
          );
        },
      ),
    );
  }
}