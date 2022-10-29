import 'package:burguer/Components/ProductAdministrationPage/product_administration_page.component.dart';
import 'package:flutter/material.dart';

class ProductWeb extends StatefulWidget {
  const ProductWeb({Key? key}) : super(key: key);

  @override
  State<ProductWeb> createState() => _ProductWebState();
}

class _ProductWebState extends State<ProductWeb> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final PageController _pageController = PageController();
  int indexNavigatorBar = 0;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: ProductAdministrationPage(
              category: "Lanche",
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: ProductAdministrationPage(
              category: "Sobremesa",
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 3,
            child: ProductAdministrationPage(
              category: "Bebida",
            ),
          ),
        ],
      ),
    );
  }
}
