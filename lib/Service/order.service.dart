import 'package:burguer/Enum/type_payment.enum.dart';
import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Model/cart_item.model.dart';
import 'package:burguer/Model/order.model.dart';
import 'package:burguer/Model/order_to_confirm.model.dart';
import 'package:burguer/Model/user.model.dart';
import 'package:burguer/Service/authentication.service.dart';
import 'package:burguer/Service/cart.service.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class OrderService {
  final firestore = FirebaseFirestore.instance;
  final AuthenticationService auth = AuthenticationService();
  final CartService cartService = CartService();

  save(OrderModel model, BuildContext context) async {
    var uuidOrder = const Uuid().v1();

    try {
      await firestore.collection('orders').doc(uuidOrder).set({
        "uid": uuidOrder,
        "uidUser": auth.getUid(),
        "userName": model.userName,
        "userEmail": model.userEmail,
        "userCellPhone": model.userCellPhone,
        "publicPlace": model.address!.publicPlace,
        "number": model.address!.number,
        "district": model.address!.district,
        "zipCode": model.address!.zipCode,
        "city": model.address!.city,
        "complement": model.address!.complement,
        "valueTotal": model.valueTotal,
        "valueDelivery": model.valueDelivery,
        "dateOrder": model.dateOrder,
        "dateOrderAccepted": model.dateOrderAccepted,
        "dateOrderSent": model.dateOrderSent,
        "status": "enviado",
        "typePayment":
            model.typePayment == TypePayment.money ? 'Dinheiro' : 'Cartão',
        "thing": model.typePayment == TypePayment.money ? model.moneyChange : 0,
        "cardFlag":
            model.typePayment == TypePayment.cardCredit ? model.cardFlag : '',
        "payment": model.typePayment == TypePayment.cardCredit
            ? model.cardPayment
            : '',
        "reasonDeclined": model.reasonDenied,
      });

      for (var i = 0; i < model.itens!.length; i++) {
        var uuidItems = const Uuid().v1();
        await firestore
            .collection('orders')
            .doc(uuidOrder)
            .collection("items")
            .doc(uuidItems)
            .set(
          {
            "price": model.itens![i].product!.price,
            "amount": model.itens![i].amount.toString(),
            "product": model.itens![i].product!.name,
            "uid": uuidItems,
          },
        );
      }
      CartService().deleteCart();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    } on FirebaseException catch (ex) {
      throw Exception(ex.message);
    }
  }

  getMyOrders() {
    return firestore
        .collection('orders')
        .where("uidUser", isEqualTo: auth.getUid())
        .orderBy("dateOrder", descending: true)
        .snapshots();
  }

  getMyOrderItens(String uid) async {
    List<Map<String, dynamic>> orderItens = [];
    await firestore
        .collection('orders')
        .doc(uid)
        .collection("items")
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        orderItens[i] = value.docs[i].data();
      }
    });
  }

  getOrders(status) {
    return firestore
        .collection('orders')
        .where("status", isEqualTo: status)
        .orderBy("dateOrder", descending: true)
        .snapshots();
  }

  acceptOrder(String uid, BuildContext context) async {
    await firestore.collection("orders").doc(uid).update({
      "status": "aceito",
      "dateOrderAccepted": DateTime.now(),
    });
    Navigator.of(context).pop();
  }

  finishOrder(String uid, BuildContext context) async {
    await firestore.collection("orders").doc(uid).update({
      "status": "entregue",
      "dateOrderSent": DateTime.now(),
    });
    Navigator.of(context).pop();
  }

  rejectOrder(String uid, String reasonDenied, BuildContext context) async {
    await firestore.collection("orders").doc(uid).update({
      "status": "recusado",
      "dateOrderAccepted": DateTime.now(),
      "dateOrderSent": DateTime.now(),
      "reasonDeclined": reasonDenied,
    });
    Navigator.of(context).pop();
  }

  Future<OrderToConfirm> getInformationsToSubmit() async {
    List<AddressModel> adresses = [];
    List<CartItemModel>? items;
    double? totalPrice;
    UserModel? user;
    await firestore
        .collection("users")
        .doc(auth.getUid())
        .collection("address")
        .get()
        .then((value) {
      for (var element in value.docs) {
        adresses.add(AddressModel.fromJson(element.data()));
      }
    });
    await cartService.getCart()!.then((value) {
      items = value.products!;
    });
    await cartService.getTotalPrice().then(
      (value) {
        totalPrice = value;
      },
    );
    await firestore.collection("users").doc(auth.getUid()).get().then(
      (value) {
        user = UserModel.fromJson(value.data()!);
      },
    );
    return OrderToConfirm(
      address: adresses,
      itens: items!,
      valueTotal: totalPrice,
      valueDelivery: 0,
      user: user,
    );
  }
}
