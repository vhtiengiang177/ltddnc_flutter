import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/category.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/list_categories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  Category? category;
  List<Category> listCategory = [];

  CategoryProvider({this.category});

  // CollectionReference categories =
  //     FirebaseFirestore.instance.collection('categories');

  // Future<void> getAll() async {
  //   print("getAllCategories");

  //   print(listCategory);
  //   listCategory = [];

  //   print(listCategory);
  //   await categories.orderBy("name").get().then((querySnapshot) {
  //     print('------------${querySnapshot.docs.length}');
  //     querySnapshot.docs.forEach((e) {
  //       final element = e.data();
  //       try {
  //         if (element is Map<String, dynamic>) {
  //           Category category = new Category(
  //               id: e.id, name: element['name'], image: element['image']);

  // // static var categories = http.;
  // final routeAPICategories = "/categories";

  //   notifyListeners();
  //   print(listCategory.length);
  // }

  final routeAPICategories = "/categories";

  Future<List<Category>> getCategories() async {
    print("get category: ");
    var response = await http.get(Uri.parse(apiHost + routeAPICategories + "/"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var categoryResponse = json.decode(response.body);
      for (var c in categoryResponse) {
        Category category =
            Category(id: c['id'], name: c['name'], image: c['image']);
        listCategory.add(category);
      }
      return listCategory;
    } else if (response.statusCode == 400) {}

    return [];
  }
}
