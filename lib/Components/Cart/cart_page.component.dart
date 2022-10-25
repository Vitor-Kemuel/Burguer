import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/Cart/cart_list.component.dart';
import 'package:burguer/Model/cart.model.dart';
import 'package:burguer/Service/cart.service.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final CartModel? cart;
  const CartPage({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;
  @override
  void initState() {
    super.initState();
    getTotalPrice();
  }

  getTotalPrice() async {
    await CartService().getTotalPrice().then((value) {
      setState(() {
        totalPrice = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 41, 41, 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 0, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Seus produtos:",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.cart!.products == null
                    ? Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                Icons.remove_shopping_cart_outlined,
                                size: 100,
                                color: Color.fromARGB(150, 255, 255, 255),
                              ),
                              Text(
                                "Seu carrinho está vazio!",
                                style: TextStyle(
                                  color: Color.fromARGB(150, 255, 255, 255),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Expanded(
                        child: CartList(
                          cartItens: widget.cart!.products!,
                        ),
                      ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                margin: const EdgeInsets.fromLTRB(40, 5, 40, 15),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 225, 225, 225),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("SubTotal: R\$ ${totalPrice.toStringAsFixed(2)}"),
                  ],
                ),
              ),
              TextButtonCustom(
                buttonText: "Finalizar",
                onPressed: () {
                  if (widget.cart!.products != null) {
                    // Navegar para a tela de confirmação
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("O carrinho está vazio"),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
