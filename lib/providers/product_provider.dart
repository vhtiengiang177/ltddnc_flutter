import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/product.dart';

class ProductProvider with ChangeNotifier {
  Product? product;
  List<Product> listProduct = [];

  ProductProvider({this.product});

  CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<void> getAllProduct() async {
    print("getAllProduct");
    listProduct = [];
    await products.get().then((querySnapshot) {
      querySnapshot.docs.forEach((e) {
        final element = e.data();
        try {
          if (element is Map<String, dynamic>) {
            Product product = new Product(
                id: e.id,
                name: element['name'],
                price: element['price'],
                image: element['image']);

            listProduct.add(product);
            print(product);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      });
    });

    notifyListeners();
  }
}
