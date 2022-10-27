import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Model/cart_item.model.dart';
import 'package:burguer/Model/user.model.dart';

class OrderToConfirm {
  List<AddressModel>? address;
  List<CartItemModel>? itens;
  double? valueDelivery;
  double? valueTotal;
  UserModel? user;

  OrderToConfirm({
    this.address,
    this.itens,
    this.valueDelivery,
    this.valueTotal,
    this.user
  });

  OrderToConfirm.fromJson(Map<String, dynamic> map) {
    address = map["address"];
    itens = map["itens"];
    valueDelivery = map["valueDelivery"];
    valueTotal = map["valueTotal"];
    user = map["user"];
  }
}