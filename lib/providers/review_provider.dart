import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/models/review.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ReviewProvider with ChangeNotifier {
  Review? review;
  List<Review> listReview = [];
  List<Review> listReviewTemp = [];

  ReviewProvider({this.review});

  final routeAPIReviews = "/reviews";
  Future<void> getReviews(int? IdProduct) async {
    print("get review: ");
    listReview = [];

    var response = await http.get(
        Uri.parse(apiHost +
            routeAPIReviews +
            "/getreviewsbyidproduct/" +
            IdProduct.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var reviewResponse = json.decode(response.body);
      for (var p in reviewResponse) {
        String createDate =
            DateFormat('dd-MM-yyyy HH:mm').format(DateTime.parse(p["date"]));
        Review review = Review(
            id: p['id'],
            idProduct: p['idProduct'],
            idUser: p['idUser'],
            name: p['name'],
            comment: p['comment'],
            image: p['image'],
            rating: p["rating"],
            date: createDate);
        listReview.add(review);
      }
      print(json.encode(listReview));
      print(listReview.length);
      notifyListeners();
    } else if (response.statusCode == 400) {}
  }

  Future<void> orderDetailMapToReview(List<OrderDetail> lOrderDetail) async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    if (id != null) {
      listReview = [];
      lOrderDetail.forEach((element) {
        Review review = Review(
            id: 0,
            idProduct: element.idProduct,
            idUser: int.parse(id),
            name: "",
            comment: "",
            date: DateTime.now().toString(),
            image: "",
            idOrder: element.idOrder,
            nameProduct: element.nameProduct,
            imageProduct: element.imageProduct,
            rating: 5);
        listReview.add(review);
      });
    }

    notifyListeners();
  }

  Future<void> addReview(List<Review> lReview) async {
    print("add review");
    print(json.encode(lReview));
    var response = await http.post(
        Uri.parse(apiHost + routeAPIReviews + "/CreateReview"),
        body: json.encode(lReview),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("add review success");
    } else if (response.statusCode == 400) {
      print("add review failed");
    }
    notifyListeners();
  }
}
