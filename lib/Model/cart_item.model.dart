import 'package:burguer/Model/product.model.dart';

class CartItemModel {
  ProductModel? product;
  int? amount;

  CartItemModel({
    required this.product,
    required this.amount,
  });

  CartItemModel.fromJson(Map<String, dynamic> map) {
    product =
        map['product'] != null ? ProductModel.fromJson(map['product']) : null;
    amount = map['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['amount'] = amount;
    return data;
  }
}
