import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/models/review.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
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
      print(listReview);
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
            idProduct: element.idProduct,
            idUser: int.parse(id),
            nameProduct: element.nameProduct,
            imageProduct: element.imageProduct,
            rating: 5);
        listReview.add(review);
      });
    }
  }

  Future<void> addReview(Review review) async {
    // listReview.add(review);
    print("add review");

    var response = await http.post(
        Uri.parse(apiHost + routeAPIReviews + "/CreateReview"),
        body: json.encode(review),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("add review success");
    } else if (response.statusCode == 400) {
      print("add review failed");
    }
    notifyListeners();
  }
}
