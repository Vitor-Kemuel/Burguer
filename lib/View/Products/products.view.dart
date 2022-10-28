import 'package:burguer/Components/AppBar/app_bar_custom.component.dart';
import 'package:burguer/Components/ProductAdministrationPage/product_administration_page.component.dart';
import 'package:burguer/Components/ProductForm/product_form.component.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductAdministration extends StatefulWidget {
  const ProductAdministration({Key? key}) : super(key: key);

  @override
  State<ProductAdministration> createState() => _ProductAdministrationState();
}

class _ProductAdministrationState extends State<ProductAdministration> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: const Color.fromARGB(255, 41, 41, 41),
      appBar: AppBarCustom(
        title: "Produtos",
        context: context,
      ),
      body: PageView(
        onPageChanged: (int page) {
          setState(() {
            indexNavigatorBar = page;
          });
        },
        controller: _pageController,
        children: const <Widget>[
          ProductAdministrationPage(
            category: "Lanche",
          ),
          ProductAdministrationPage(
            category: "Sobremesa",
          ),
          ProductAdministrationPage(
            category: "Bebida",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
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
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(500, 50),
            topRight: Radius.elliptical(500, 50),
          ),
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
              label: "Lanche",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.icecream_outlined),
              label: "Sobremesa",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_drink_rounded),
              label: "Bebida",
            ),
          ],
        ),
      ),
    );
  }
}
