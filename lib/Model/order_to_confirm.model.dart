import 'package:burguer/Model/address.model.dart';
import 'package:burguer/Model/cart_item.model.dart';
import 'package:burguer/Model/user.model.dart';

class OrderToConfirm {
  List<AddressModel>? address;
  List<CartItemModel>? items;
  double? valueDelivery;
  double? valueTotal;
  UserModel? user;

  OrderToConfirm({
    this.address,
    this.items,
    this.valueDelivery,
    this.valueTotal,
    this.user
  });

  OrderToConfirm.fromJson(Map<String, dynamic> map) {
    address = map["address"];
    items = map["items"];
    valueDelivery = map["valueDelivery"];
    valueTotal = map["valueTotal"];
    user = map["user"];
  }
}