import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/shared/constants.dart';
import 'dart:convert';

class FavoriteProvider with ChangeNotifier {
  Product? product;
  List<Product> listProduct = [];

  FavoriteProvider({this.product});

  final routeAPIFavourites = "/favorites";
  Future<void> getProducts(int? IdUser) async {
    print("get favorite: ");
    listProduct = [];

    var response = await http.get(
        Uri.parse(apiHost +
            routeAPIFavourites +
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

  Future<void> removeFavorite(int? IdUser, Product product) async {
    listProduct.removeWhere((element) => element.id == product.id);
    print("remove favorite");
    var response = await http.delete(
        Uri.parse(apiHost +
            routeAPIFavourites +
            "/DeleteItemInFavorite/" +
            IdUser.toString() +
            "&&" +
            product.id.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("remove favorite success");
    } else if (response.statusCode == 400) {
      print("remove favorite failed");
    }
    notifyListeners();
  }

  Future<void> addFavorite(int? IdUser, Product product) async {
    listProduct.add(product);
    print("add favorite");

    var response = await http.post(
        Uri.parse(apiHost +
            routeAPIFavourites +
            "/AddItemToFavorite/" +
            IdUser.toString() +
            "&&" +
            product.id.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("add favorite success");
    } else if (response.statusCode == 400) {
      print("add favorite failed");
    }
    notifyListeners();
  }
}
