import 'package:burguer/View/NewAddress/new_address.view.dart';
import 'package:burguer/View/NewProduct/new_product.view.dart';
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
                  "Novo Produto",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                trailing: const Icon(
                  Icons.house_outlined,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NewProduct(),
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
                  "Novo Endereço",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                trailing: const Icon(
                  Icons.person_outline_rounded,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewAddress(),
                    ),
                  );
                },
              ),
            ],
          );
  }
}
