import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/shared/constants.dart';
import 'dart:convert';

class FavoriteProvider with ChangeNotifier {
  Product? product;
  List<Product> listProduct = [];

  FavoriteProvider({this.product});

  final routeAPIProducts = "/favorites";
  Future<void> getProducts(int? IdUser) async {
    print("get product: ");
    listProduct = [];

    var response = await http.get(
        Uri.parse(apiHost +
            routeAPIProducts +
            "/GetAllItemsInFavorite/" +
            IdUser.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var productResponse = json.decode(response.body);
      for (var p in productResponse) {
        Product product = Product(
            id: p['id'],
            name: p['name'],
            unitPrice: p['unitPrice'],
            image: p['image'],
            description: p["description"]);
        listProduct.add(product);
      }
      print(listProduct);
      notifyListeners();
    } else if (response.statusCode == 400) {}
  }
}
