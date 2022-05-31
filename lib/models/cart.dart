import 'dart:convert';

import 'package:ltddnc_flutter/models/product.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  final int? idUser;
  final int? idProduct;
  int? quantity;
  final Product? product;
  bool? selected;

  Cart({this.idUser, this.idProduct, this.quantity, this.product, this.selected = false});

  Map<String, dynamic> toJson() => {
        "idUser": idUser,
        "idProduct": idProduct,
        "quantity": quantity,
        "product": product
      };

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      idUser: json["idUser"],
      idProduct: json["idProduct"],
      quantity: json["quantity"],
      product: json["product"]);
}
