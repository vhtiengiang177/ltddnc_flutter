import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/shared/constants.dart';
import 'dart:convert';

class ProductProvider with ChangeNotifier {
  Product? product;
  List<Product> listProduct = [];
  List<Product> listTop10Product = [];

  ProductProvider({this.product});

  // CollectionReference products =
  //     FirebaseFirestore.instance.collection('products');
  // CollectionReference categories =
  //     FirebaseFirestore.instance.collection('categories');

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
  Future<void> getProducts(int? IdCategories) async {
    print("get product: ");
    listProduct = [];

    var response = await http.get(
        Uri.parse(apiHost +
            routeAPIProducts +
            "/getproductbycategoryid/" +
            IdCategories.toString()),
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

    Future<void> getTop10NewProduct() async {
    print("getTop10NewProduct: ");
    listTop10Product = [];

    var response = await http.get(
        Uri.parse(apiHost +
            routeAPIProducts +
            "/getTop10NewProduct/"),
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
        listTop10Product.add(product);
      }
      print(listTop10Product);
      notifyListeners();
    } else if (response.statusCode == 400) {}
  }
}
