import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String userToJson(Category data) => json.encode(data.toJson());
class Category {
  final int? id;
  final String? name;
  final String? image;

  Category({this.id, this.name, this.image});

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image
  };

  factory Category.fromJson(Map<String, dynamic> json) => Category(
      id: json["id"],
      name: json["name"],
      image: json["image"]);
}
