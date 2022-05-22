import 'dart:convert';

OrderDetail orderDetailFromJson(String str) => OrderDetail.fromJson(json.decode(str));
String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  final int? idOrder;
  final int? idProduct;
  final double? unitPrice;
  final int? quantity;

  OrderDetail({this.idOrder, this.idProduct, this.unitPrice, this.quantity});

  Map<String, dynamic> toJson() => {
        "idOrder": idOrder,
        "idProduct": idProduct,
        "unitPrice": unitPrice,
        "quantity": quantity
      };

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
      idOrder: json["idOrder"],
      idProduct: json["idProduct"],
      unitPrice: json["unitPrice"],
      quantity: json["quantity"]);
}