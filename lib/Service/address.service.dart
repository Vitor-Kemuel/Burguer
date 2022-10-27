import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:uuid/uuid.dart';

class AddressException implements Exception {
  String message;
  AddressException(this.message);
}

class AddressService extends ChangeNotifier {
  final firestore = FirebaseFirestore.instance;
  final AuthenticationService auth = AuthenticationService();

  registration(AddressModel model, BuildContext context) {
    var uuid = const Uuid();
    var uid = uuid.v1();
    try {
      firestore
          .collection('users')
          .doc(auth.getUid())
          .collection("address")
          .doc(uid)
          .set({
        "district": model.district,
        "zipCode": model.zipCode,
        "city": model.city,
        "complement": model.complement,
        "publicPlace": model.publicPlace,
        "name": model.name,
        "number": model.number,
        "uid": uid,
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }

  update(AddressModel model, BuildContext context) {
    try {
      firestore
          .collection('users')
          .doc(auth.getUid())
          .collection("address")
          .doc(model.uid)
          .update({
        "district": model.district,
        "zipCode": model.zipCode,
        "city": model.city,
        "complement": model.complement,
        "publicPlace": model.publicPlace,
        "name": model.name,
        "number": model.number,
        "uid": model.uid
      });
    } on FirebaseException catch (e) {
      throw Exception(e.code);
    }

    Navigator.of(context).pop();
  }

  getAddress() {
    return firestore
        .collection("users")
        .doc(auth.getUid())
        .collection("address")
        .snapshots();
  }
}