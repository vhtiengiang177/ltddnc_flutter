import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());

class Product {
  final int? id;
  final String? name;
  final double? unitPrice;
  final String? image;
  final String? description;
  final int? stock;
  final int? state;
  final int? idCategory;
  final String? createdDate;

  Product(
      {this.id,
      this.name,
      this.unitPrice,
      this.image,
      this.description,
      this.stock,
      this.state,
      this.idCategory,
      this.createdDate
      });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "unitPrice": unitPrice,
        "image": image,
        "description": description,
        "stock": stock,
        "state": state,
        "idCategory": idCategory,
        "createdDate": createdDate
      };

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json["id"],
      name: json["name"],
      unitPrice: json["unitPrice"],
      image: json["image"],
      description: json["description"],
      stock: json["stock"],
      state: json["state"],
      idCategory: json["idCategory"],
      createdDate: json["createdDate"]);
}
