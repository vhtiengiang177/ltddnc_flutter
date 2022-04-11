import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/category.dart';

class CategoryProvider with ChangeNotifier {
  Category? category;
  List<Category> listCategory = [];

  CategoryProvider({this.category});

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> getAll() async {
    print("getAllCategories");
    listCategory = [];
    await categories.get().then((querySnapshot) {
      querySnapshot.docs.forEach((e) {
        final element = e.data();
        try {
          if (element is Map<String, dynamic>) {
            Category category = new Category(
                id: e.id, name: element['name'], image: element['image']);

            listCategory.add(category);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      });
    });

    notifyListeners();
  }
}
