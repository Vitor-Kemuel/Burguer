import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/Drawer/drawer_custom.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 41, 41, 41),
      drawer: DrawerCustom(
        admin: false,
      ),
      appBar: AppBarCustom(
        title: "Cardapio",
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
          Container(
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
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
              icon: Icon(Icons.fastfood_outlined),
              label: "Laches",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.icecream_outlined),
              label: "Sobremesa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_rounded),
              label: "Bebidas",
            ),
          ],
        ),
      ),
    );
  }
}
