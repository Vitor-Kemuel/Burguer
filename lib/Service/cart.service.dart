import 'package:burguer/Model/cart.model.dart';
import 'package:burguer/Model/cart_item.model.dart';
import 'package:burguer/Model/product.model.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'dart:convert';

class CartException implements Exception {
  String message;
  CartException(this.message);
}

class CartService {
  final SessionManager session = SessionManager();
  CartService() {
    _cartService();
  }
  _cartService() async {
    if (!await SessionManager().containsKey("cart")) {
      await session.set("cart", "");
    }
  }

  addToCart(ProductModel item, int amount) async {
    CartModel cartModel = CartModel();
    if (await SessionManager().containsKey("cart")) {
      var response = await session.get("cart");
      if (response != "") {
        cartModel = CartModel.fromMap(response);
      }
    }
    if (cartModel.products != null) {
      cartModel.products!.add(CartItemModel(product: item, amount: amount));
    } else {
      var newItem = CartItemModel(product: item, amount: amount);
      cartModel.products = [newItem];
    }

    var jsonString = cartModel.toJson();
    await session.set("cart", json.encode(jsonString));
  }

  Future<CartModel>? getCart() async {
    if (await SessionManager().containsKey("cart")) {
      var response = await session.get("cart");
      if (response != "") {
        return CartModel.fromMap(await session.get("cart"));
      } else {
        return CartModel(products: null);
      }
    }
    return CartModel(products: null);
  }
}
