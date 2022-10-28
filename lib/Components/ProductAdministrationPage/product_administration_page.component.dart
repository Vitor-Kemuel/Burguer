import 'package:burguer/Components/ProductForm/product_form.component.dart';
import 'package:burguer/Model/product.model.dart';
import 'package:burguer/Service/product.service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductAdministrationPage extends StatefulWidget {
  final String category;

  const ProductAdministrationPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<ProductAdministrationPage> createState() =>
      _ProductAdministrationPageState();
}

class _ProductAdministrationPageState extends State<ProductAdministrationPage> {
  ProductService productService = ProductService();
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 41, 41, 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  ProductService().getAllProductsByCategory(widget.category),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                products = [];
                for (var element in snapshot.data!.docs) {
                  products.add(ProductModel.fromJson(element.data()));
                }
                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                        padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(25, 10, 10, 10),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                          color: Color.fromARGB(255, 114, 114, 114),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  products[index].name!,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: const Divider(
                                    color: Color.fromARGB(100, 255, 255, 255),
                                    height: 2,
                                  ),
                                ),
                                Text(
                                  products[index].note!,
                                  style: const TextStyle(
                                    color: Color.fromARGB(200, 255, 255, 255),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                snapshot.data!.docs[index]["price"]
                                    .toStringAsFixed(2)
                                    .replaceAll(".", ","),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      onTap: () async {
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => ProductForm(
                            model: ProductModel(
                                category: products[index].category,
                                name: products[index].name,
                                status: products[index].status,
                                uid: products[index].uid,
                                price: products[index].price,
                                note: products[index].note,
                              ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
