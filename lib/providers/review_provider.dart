import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/models/review.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'dart:convert';

class ReviewProvider with ChangeNotifier {
  Review? review;
  List<Review> listReview = [];

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
        Review review = Review(
            id: p['id'],
            idProduct: p['idProduct'],
            idUser: p['idUser'],
            name: p['name'],
            comment: p['comment'],
            image: p['image'],
            rating: p["rating"]);
        listReview.add(review);
      }
      print(listReview);
      print(listReview.length);
      notifyListeners();
    } else if (response.statusCode == 400) {}
  }
}
