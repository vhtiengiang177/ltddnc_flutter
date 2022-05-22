import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/models/order_params.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

class OrderProvider with ChangeNotifier {
  Order? order;
  List<Order> listOrder = [];

  OrderProvider({this.order});
  static var client = http.Client();
  final routeAPIOrder = "/orders";

  Future<int> createOrder(OrderParams orderParams) async {
    print("createOrder: ");
    print(json.encode(orderParams));
    var response = await client.post(
        Uri.parse(apiHost + routeAPIOrder + "/createOrder"),
        body: json.encode(orderParams),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);

    return (response.statusCode);
  }
}
