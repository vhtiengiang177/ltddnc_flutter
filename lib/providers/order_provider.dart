import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/models/order_params.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> getOrderByState(int state) async {
    print("getOrderByState: " + state.toString());
    listOrder = [];
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    if (id != null) {
      var response = await client.get(Uri.parse(apiHost +
          routeAPIOrder +
          "/GetOrderByState/" +
          id +
          "&&" +
          state.toString()));
      if (response.statusCode == 200) {
        var orderResponse = json.decode(response.body);
        for (var o in orderResponse) {
          OrderDetail firstOrderDetail = OrderDetail(
              idOrder: o["firstOrderDetail"]["idOrder"],
              idProduct: o["firstOrderDetail"]["idProduct"],
              nameProduct: o["firstOrderDetail"]["nameProduct"],
              imageProduct: o["firstOrderDetail"]["imageProduct"],
              unitPrice: o["firstOrderDetail"]["unitPrice"],
              quantity: o["firstOrderDetail"]["quantity"]);
          Order order = Order(
              id: o["id"],
              state: o["state"],
              totalQuantity: o["totalQuantity"],
              totalProductPrice: o["totalProductPrice"],
              name: o["name"],
              phone: o["phone"],
              address: o["address"],
              idUser: o["idUser"],
              firstOrderDetail: firstOrderDetail);
          listOrder.add(order);
        }
        print(listOrder.length);
        notifyListeners();
      }
    }
  }
}
