import 'dart:convert';

import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';

OrderParams orderParamsFromJson(String str) => OrderParams.fromJson(json.decode(str));
String orderParamsToJson(OrderParams data) => json.encode(data.toJson());

class OrderParams {
  final Order? order;
  final List<OrderDetail>? listOrderDetail;

  OrderParams({this.order, this.listOrderDetail});

  Map<String, dynamic> toJson() => {
        "order": order,
        "listOrderDetail": listOrderDetail
      };

  factory OrderParams.fromJson(Map<String, dynamic> json) => OrderParams(
      order: json["order"],
      listOrderDetail: json["listOrderDetail"]);
}