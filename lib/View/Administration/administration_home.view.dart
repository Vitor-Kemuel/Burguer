import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/Drawer/drawer_custom.component.dart';
import 'package:burguer/Components/OrderPage/order_page.component.dart';
import 'package:flutter/material.dart';

class AdministrationHomeView extends StatefulWidget {
  const AdministrationHomeView({super.key});

  @override
  State<AdministrationHomeView> createState() => _AdministrationHomeViewState();
}

class _AdministrationHomeViewState extends State<AdministrationHomeView> {
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;

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
      body: PageView(
        onPageChanged: (int page) {
          setState(() {
            indexNavigatorBar = page;
          });
        },
        controller: _pageController,
        children: [
          OrderPage(
            status: "enviado",
          ),
          OrderPage(
            status: "aceito",
          ),
          OrderPage(
            status: "entregue",
          ),

        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        child: BottomNavigationBar(
          onTap: (int page) {
            setState(() {
              indexNavigatorBar = page;
            });
            _pageController.jumpToPage(
              page,
            );
          },
          currentIndex: indexNavigatorBar,
          elevation: 0,
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          fixedColor: Colors.red,
          unselectedItemColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.new_label_outlined),
              label: "Novos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_outlined),
              label: "Aceitos",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.delivery_dining_outlined),
              label: "Entregues",
            ),
          ],
        ),
      ),
    );
  }
}
