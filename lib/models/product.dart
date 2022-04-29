import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String userToJson(Product data) => json.encode(data.toJson());

class Product {
  final int? id;
  final String? name;
  final double? unitPrice;
  final String? image;
  final String? description;

  Product({this.id, this.name, this.unitPrice, this.image, this.description});

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "unitPrice": unitPrice,
    "image": image,
    "description": description
  };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      unitPrice: json["unitPrice"],
      image: json["image"],
      description: json["description"]);
}
