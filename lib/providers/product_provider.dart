import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/shared/constants.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  Product? product;
  List<Product> listProduct = [];

  ProductProvider({this.product});

  // CollectionReference products =
  //     FirebaseFirestore.instance.collection('products');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  // Future<void> getAll(idCategory) async {
  //   print(idCategory);
  //   listProduct = [];
  //   await categories
  //       .doc(idCategory)
  //       .collection('products')
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((e) {
  //       final element = e.data();
  //       try {
  //         if (element is Map<String, dynamic>) {
  //           Product product = new Product(
  //               id: e.id,
  //               name: element['name'],
  //               price: element['price'],
  //               image: element['image'],
  //               description: element['description']);
  //
  //           listProduct.add(product);
  //           print(product);
  //         }
  //       } on Exception catch (e) {
  //         print(e.toString());
  //       }
  //     });
  //   });
  //
  //   notifyListeners();
  // }

  final routeAPIProducts = "/products";
  Future<List<Product>> getProducts(int? IdCategories) async {
    print("get product: ");
    var count =0;
    var response = await http.get(
        Uri.parse(
            apiHost + routeAPIProducts + "/getproductbycategoryid/" + IdCategories.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var productResponse = json.decode(response.body);
      for (var p in productResponse){
        Product product = Product(id: p['id'],name: p['name'],price: p['price'], image: p['image'], description: p["description"]);
        listProduct.add(product);
        count=count+1;
      }
      print(count.toString());
      return listProduct;

    } else if (response.statusCode == 400) {
    }

    return [];
  }
}
