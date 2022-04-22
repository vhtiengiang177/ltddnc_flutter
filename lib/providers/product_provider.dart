import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/product.dart';

class ProductProvider with ChangeNotifier {
  Product? product;
  List<Product> listProduct = [];

  ProductProvider({this.product});

  // CollectionReference products =
  //     FirebaseFirestore.instance.collection('products');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> getAll(idCategory) async {
    print(idCategory);
    listProduct = [];
    await categories
        .doc(idCategory)
        .collection('products')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((e) {
        final element = e.data();
        try {
          if (element is Map<String, dynamic>) {
            Product product = new Product(
                id: e.id,
                name: element['name'],
                price: element['price'],
                image: element['image'],
                description: element['description']);

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
