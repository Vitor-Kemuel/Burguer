import 'package:burguer/Components/productsPage/product_information.component.dart';
import 'package:burguer/Model/product.model.dart';
import 'package:burguer/Service/product.service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProductPage extends StatelessWidget {
  final String category;

  const ProductPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 41, 41, 41),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: ProductService().getActiveProductsByCategory(category),
              builder: (_, snapshot) {
                if (!snapshot.hasData) return const CircularProgressIndicator();
                return ListView.builder(
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (_, index) {
                    return InkWell(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                        width: MediaQuery.of(context).size.width,
                        height: 70,
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
                        child: Container(
                          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data!.docs[index]["name"],
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                snapshot.data!.docs[index]["price"]
                                    .toString()
                                    .replaceAll(".", ","),
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        showBarModalBottomSheet(
                          context: context,
                          builder: (context) => ProductInformation(
                            product: ProductModel.fromMap(
                                snapshot.data!.docs[index].data()),
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
