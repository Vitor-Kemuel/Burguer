import 'package:burguer/Enum/type_payment.enum.dart';
import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Model/cart_item.model.dart';

class OrderModel {
  AddressModel? address;
  String? cardFlag;
  String? cardPayment;
  DateTime? dateOrder;
  DateTime? dateOrderAccepted;
  DateTime? dateOrderSent;
  String? id;
  List<CartItemModel>? items;
  String? moneyChange;
  String? status;
  TypePayment? typePayment;
  String? userEmail;
  String? userName;
  String? userCellPhone;
  double? valueDelivery;
  double? valueTotal;
  String? reasonDenied;

  OrderModel({
    this.address,
    this.cardFlag,
    this.cardPayment,
    this.dateOrder,
    this.dateOrderAccepted,
    this.dateOrderSent,
    this.id,
    this.items,
    this.moneyChange,
    this.status,
    this.typePayment,
    this.userEmail,
    this.userName,
    this.userCellPhone,
    this.valueDelivery,
    this.valueTotal,
    this.reasonDenied,
  });

  OrderModel.fromJson(Map<String, dynamic> map) {
    address = AddressModel.fromJson(map["address"]);
    cardFlag = map["cardFlag"];
    cardPayment = map["cardPayment"];
    dateOrder = map["dateOrder"];
    dateOrderAccepted = map["dateOrderAccepted"];
    dateOrderSent = map["dateOrderSent"];
    id = map["uid"];
    if (map["items"].runtimeType == List<CartItemModel>) {
      items = map["items"];
    } else {
      items = [];
      for (var element in map["items"]) {
        items!.add(CartItemModel.fromJson(element));
      }
    }
    moneyChange = map["moneyChange"];
    status = map["status"];
    if (map["typePayment"].runtimeType == TypePayment) {
      typePayment = map["typePayment"];
    } else {
      typePayment = map["typePayment"] == "money"
          ? TypePayment.money
          : TypePayment.cardCredit;
    }
    userEmail = map["userEmail"];
    userName = map["userName"];
    userCellPhone = map["userCellPhone"];
    valueDelivery = map["valueDelivery"];
    valueTotal = map["valueTotal"];
    reasonDenied = map["reasonDenied"];
  }
}
