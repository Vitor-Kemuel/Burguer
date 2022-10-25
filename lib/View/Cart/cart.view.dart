import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Core/Container/cart.container.dart';
import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        context: context,
        title: "Carrinho",
      ),
      body: CartContainer(),
    );
  }
}
