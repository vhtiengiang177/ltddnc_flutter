import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  Cart? cart;
  List<Product> listProduct = [];

  CartProvider({this.cart});

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> getCart() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.get("userData");
    listProduct = [];
    await users
        .doc(userId as String)
        .collection('carts')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((e) {
        final element = e.data();
        try {
          if (element is Map<String, dynamic>) {
            categories
                .doc(element["idCategory"])
                .collection('products')
                .where("id", isEqualTo: element["idProduct"])
                .get()
                .then((value) {
              value.docs.forEach((e) {
                final element = e.data();

                if (element is Map<String, dynamic>) {
                  Product product = new Product(
                      id: e.id,
                      name: element['name'],
                      price: element['price'],
                      image: element['image'],
                      description: element['description']);

                  listProduct.add(product);
                }
              });
            });
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      });
    });

    notifyListeners();
  }
}
