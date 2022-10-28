import 'package:burguer/View/Address/address.view.dart';
import 'package:burguer/View/MyOrders/my_orders.view.dart';
import 'package:burguer/View/Products/products.view.dart';
import 'package:flutter/material.dart';

class OptionsDrawer extends StatelessWidget {
  final bool admin;
  const OptionsDrawer({
    super.key,
    required this.admin,
  });

  @override
  Widget build(BuildContext context) {
    return admin
        ? ListView(
            children: [
              ListTile(
                title: const Text(
                  "Produtos",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                trailing: const Icon(
                  Icons.fastfood_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductAdministration(),
                    ),
                  );
                },
              ),
            ],
          )
        : ListView(
            children: [
              ListTile(
                title: const Text(
                  "Meus endereços",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                trailing: const Icon(
                  Icons.house_sharp,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Adresses(),
                    ),
                  );
                },
              ),
                            ListTile(
                title: const Text(
                  "Meus pedidos",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                trailing: const Icon(
                  Icons.wysiwyg_sharp,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MyOrders(),
                    ),
                  );
                },
              ),
            ],
          );
  }
}
