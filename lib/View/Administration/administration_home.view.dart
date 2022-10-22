import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/Drawer/drawer_custom.dart';
import 'package:flutter/material.dart';

class AdministrationHomeView extends StatefulWidget {
  const AdministrationHomeView({super.key});

  @override
  State<AdministrationHomeView> createState() => _AdministrationHomeViewState();
}

class _AdministrationHomeViewState extends State<AdministrationHomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      drawer: DrawerCustom(
        admin: true,
      ),
      appBar: AppBarCustom(
        title: "Administração",
        context: context,
        isDrawer: true,
      ),
      body: ListView(children: [
        Center(
          child: Text("home"),
        ),
      ]),
    );
  }
}
