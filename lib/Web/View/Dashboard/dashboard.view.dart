import 'package:burguer/Components/Buttons/text_button_custom.component.dart';
import 'package:burguer/Components/ProductForm/product_form.component.dart';
import 'package:burguer/Web/View/Orders/orders_web.view.dart';
import 'package:burguer/Web/View/Products/products_web.view.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class WebDashboardView extends StatefulWidget {
  const WebDashboardView({super.key});

  @override
  State<WebDashboardView> createState() => _WebDashboardViewState();
}

class _WebDashboardViewState extends State<WebDashboardView> {
  final List<Map<String, dynamic>> renderPage = [
    {"page": OrdersWeb(), "name": "Pedidos"},
    {"page": ProductWeb(), "name": "Produtos"},
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            height: MediaQuery.of(context).size.height / 10,
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  renderPage[index]["name"],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                  ),
                ),
                Row(
                  children: [
                    TextButtonCustom(
                      buttonText: "Pedidos",
                      onPressed: () {
                        setState(() {
                          index = 0;
                        });
                      },
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    TextButtonCustom(
                      buttonText: "Produtos",
                      onPressed: () {
                        setState(() {
                          index = 1;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          renderPage[index]["page"],
        ],
      ),
      floatingActionButton: renderPage[index]["name"] == "Produtos"
          ? FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.fastfood_outlined,
                color: Color.fromARGB(255, 240, 240, 240),
              ),
              onPressed: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => ProductForm(),
                );
              },
            )
          : Container(),
    );
  }
}
