import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Cart? cart;
  List<Cart> listCart = [];

  CartProvider({this.cart});
  static var client = http.Client();
  final routeAPICart = "/carts";

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // CollectionReference categories =
  //     FirebaseFirestore.instance.collection('categories');

  // Future<void> getCart() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final userId = prefs.get("userData");
  //   listProduct = [];
  //   await users
  //       .doc(userId as String)
  //       .collection('carts')
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((e) {
  //       final element = e.data();
  //       try {
  //         if (element is Map<String, dynamic>) {
  //           categories
  //               .doc(element["idCategory"])
  //               .collection('products')
  //               .where("id", isEqualTo: element["idProduct"])
  //               .get()
  //               .then((value) {
  //             value.docs.forEach((e) {
  //               final element = e.data();

  //               if (element is Map<String, dynamic>) {
  //                 Product product = new Product(
  //                     // id: e,
  //                     name: element['name'],
  //                     unitPrice: element['unitPrice'],
  //                     image: element['image'],
  //                     description: element['description']);

  //                 listProduct.add(product);
  //               }
  //             });
  //           });
  //         }
  //       } on Exception catch (e) {
  //         print(e.toString());
  //       }
  //     });
  //   });

  //   notifyListeners();
  // }

  Future<void> getCart(int? idUser) async {
    print("getCart: ");
    listCart = [];

    var response = await client.get(
        Uri.parse(
            apiHost + routeAPICart + "/GetAllItemsInCart/" + idUser.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("response body " + response.body);
      var cartResponse = json.decode(response.body);
      for (var c in cartResponse) {
        Product product = Product(
            id: c['product']['id'],
            name: c['product']['name'],
            description: c['product']['description'],
            unitPrice: c['product']['unitPrice'],
            image: c['product']['image'],
            stock: c['product']['stock'],
            state: c['product']['state'],
            idCategory: c['product']['stock']);
        Cart cart = Cart(
            idUser: c['idUser'],
            idProduct: c['idProduct'],
            quantity: c['quantity'],
            product: product);
        listCart.add(cart);
      }
      print(listCart.length);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("cart", response.body);
      notifyListeners();
    } else if (response.statusCode == 400) {
      print("getCart failed");
    }
  }

  Future<void> getCartLocal() async {
    print("getCartLocal: ");
    listCart = [];

    final prefs = await SharedPreferences.getInstance();
    String response = prefs.getString("cart").toString();

    var cartResponse = json.decode(response);
    for (var c in cartResponse) {
      Product product = Product(
          id: c['product']['id'],
          name: c['product']['name'],
          description: c['product']['description'],
          unitPrice: c['product']['unitPrice'],
          image: c['product']['image'],
          stock: c['product']['stock'],
          state: c['product']['state'],
          idCategory: c['product']['stock']);
      Cart cart = Cart(
          idUser: c['idUser'],
          idProduct: c['idProduct'],
          quantity: c['quantity'],
          product: product);
      listCart.add(cart);
    }

    notifyListeners();
  }

  Future<String> addItem(Cart cart) async {
    print("addItem: ");

    var response = await client.post(
        Uri.parse(apiHost + routeAPICart + "/AddItem"),
        body: cartToJson(cart),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return (response.body);
    } else if (response.statusCode == 400) {
      print("Failed");
      return (response.body);
    }

    return "Lỗi hệ thống";
  }

  Future<Response> deleteItems(List<Cart> listCartDeleted) async {
    print("deleteItems: ");
    print(listCartDeleted);

    var response = await client.post(
        Uri.parse(apiHost + routeAPICart + "/DeleteItemsInCart"),
        body: json.encode(listCartDeleted),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);

    notifyListeners();
    return (response);
  }

  Future<void> onQuantityChanged() async {
    var newListCarts = json.encode(listCart);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", newListCarts);
  }
}
