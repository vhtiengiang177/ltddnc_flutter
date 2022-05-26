import 'dart:convert';

OrderDetail orderDetailFromJson(String str) =>
    OrderDetail.fromJson(json.decode(str));
String orderDetailToJson(OrderDetail data) => json.encode(data.toJson());

class OrderDetail {
  final int? idOrder;
  final int? idProduct;
  final String? nameProduct;
  final String? imageProduct;
  final double? unitPrice;
  final int? quantity;

  OrderDetail(
      {this.idOrder,
      this.idProduct,
      this.nameProduct,
      this.imageProduct,
      this.unitPrice,
      this.quantity});

  Map<String, dynamic> toJson() => {
        "idOrder": idOrder,
        "idProduct": idProduct,
        "nameProduct": nameProduct,
        "imageProduct": imageProduct,
        "unitPrice": unitPrice,
        "quantity": quantity
      };

  factory OrderDetail.fromJson(Map<String, dynamic> json) => OrderDetail(
      idOrder: json["idOrder"],
      idProduct: json["idProduct"],
      nameProduct: json["nameProduct"],
      imageProduct: json["imageProduct"],
      unitPrice: json["unitPrice"],
      quantity: json["quantity"]);
}
