import 'package:burguer/Model/product.model.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

class ProductException implements Exception {
  String message;
  ProductException(this.message);
}

class ProductService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  Map<int, Map<String, dynamic>> itens = {};
  Map<int, Map<String, dynamic>> sizes = {};

  registration(ProductModel model, BuildContext context) {
    var uuid = const Uuid();
    var uidProduct = uuid.v1();
    try {
      firestore.collection('products').doc(uidProduct).set({
        "category": model.category,
        "name": model.name,
        "status": model.status,
        "uid": uidProduct,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }

  getActiveProductsByCategory(category) {
    return firestore
        .collection('products')
        .where("category", isEqualTo: category)
        .where("status", isEqualTo: "Ativo")
        .snapshots();
  }

  getAllProductsByCategory(category) {
    return firestore
        .collection('products')
        .where("category", isEqualTo: category)
        .snapshots();
  }

  update(ProductModel model, BuildContext context) async {
    try {
      await firestore.collection('products').doc(model.uid).update({
        "category": model.category,
        "name": model.name,
        "status": model.status,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }
}