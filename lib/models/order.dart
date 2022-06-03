import 'dart:convert';

import 'package:ltddnc_flutter/models/order_detail.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));
String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  final int? id;
  int? state;
  final int? totalQuantity;
  final double? totalProductPrice;
  final String? name;
  final String? phone;
  final String? address;
  final int? idUser;
  final String? createDate;
  String? cancelDate;
  final OrderDetail? firstOrderDetail;
  int? reviewState;

  Order(
      {this.id,
      this.state,
      this.totalQuantity,
      this.totalProductPrice,
      this.name,
      this.phone,
      this.address,
      this.idUser,
      this.createDate,
      this.firstOrderDetail,
      this.reviewState,
      this.cancelDate});

  Map<String, dynamic> toJson() => {
        "id": id,
        "state": state,
        "totalQuantity": totalQuantity,
        "totalProductPrice": totalProductPrice,
        "name": name,
        "phone": phone,
        "address": address,
        "idUser": idUser,
        "createDate": createDate,
        "firstOrderDetail": firstOrderDetail,
        "reviewState": reviewState,
        "cancelDate": cancelDate
      };

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"],
      state: json["state"],
      totalQuantity: json["totalQuantity"],
      totalProductPrice: json["totalProductPrice"],
      name: json["name"],
      phone: json["phone"],
      address: json["address"],
      idUser: json["idUser"],
      createDate: json["createDate"],
      cancelDate: json["cancelDate"],
      firstOrderDetail: json["firstOrderDetail"],
      reviewState: json["reviewState"]);
}
