import 'package:burguer/Model/cart_item.model.dart';

class CartModel {
  List<CartItemModel>? products;

  CartModel({
    this.products,
  });

  CartModel.fromMap(Map<String, dynamic> map) {
    if (map['products'] != null) {
      products = <CartItemModel>[];
      map['products'].forEach((v) {
        products!.add(CartItemModel.fromMap(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (products != null) {
      data['products'] = products!.map((value) => value.toJson()).toList();
    }
    return data;
  }
}
