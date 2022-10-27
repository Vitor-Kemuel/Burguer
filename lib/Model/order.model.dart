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
  List<CartItemModel>? itens;
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
    this.itens,
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
    address = map["address"];
    cardFlag = map["cardFlag"];
    cardPayment = map["cardPayment"];
    dateOrder = map["dateOrder"];
    dateOrderAccepted = map["dateOrderAccepted"];
    dateOrderSent = map["dateOrderSent"];
    id = map["id"];
    itens = map["itens"];
    moneyChange = map["moneyChange"];
    status = map["status"];
    typePayment = map["typePayment"];
    userEmail = map["userEmail"];
    userName = map["userName"];
    userCellPhone = map["userCellPhone"];
    valueDelivery = map["valueDelivery"];
    valueTotal = map["valueTotal"];
    reasonDenied = map["reasonDenied"];
  }
}