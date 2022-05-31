import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/category.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:http/http.dart' as http;

class CategoryProvider with ChangeNotifier {
  Category? category;
  List<Category> listCategory = [];

  CategoryProvider({this.category});

  final routeAPICategories = "/categories";

  Future<void> getCategories() async {
    print("get category: ");
    listCategory = [];
    var response = await http.get(Uri.parse(apiHost + routeAPICategories + "/"),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var categoryResponse = json.decode(response.body);
      for (var c in categoryResponse) {
        Category category = 
            Category(id: c['id'], name: c['name'], image: c['image']);
        listCategory.add(category);
      }

      notifyListeners();
    } 
    else if (response.statusCode == 400) {}
  }
}
