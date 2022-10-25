import 'package:burguer/Model/cart_item.model.dart';
import 'package:burguer/Service/cart.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';

class CartProduct extends StatelessWidget {
  final CartItemModel cartItem;
  final int index;
  final CartService cartService = CartService();

  CartProduct({
    Key? key,
    required this.cartItem,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 225, 225, 225),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(10, 5, 0, 30),
                  child: Text(
                    "${cartItem.amount}x",
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text(
                      "${cartItem.product!.name!} - ${cartItem.product!.price}",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
            child: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                SessionManager().destroy();
              },
            ),
          ),
        ],
      ),
    );
  }
}
