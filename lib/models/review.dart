import 'dart:convert';

// Review reviewFromJson(String str) => Review.fromJson(json.decode(str));
// String reviewtToJson(Review data) => json.encode(data.toJson());

class Review {
  final int? id;
  final int? idProduct;
  final int? idUser;
  final String? name;
  final String? comment;
  final String? date;
  final String? image;
  final double? rating;

  Review(
      {this.id,
      this.idProduct,
      this.idUser,
      this.name,
      this.comment,
      this.date,
      this.image,
      this.rating});

  Map<String, dynamic> toJson() => {
        "id": id,
        "idProduct": idProduct,
        "idUser": idUser,
        "name": name,
        "comment": comment,
        "date": date,
        "image": image,
        "rating": rating
      };

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json["id"],
      idProduct: json["idProduct"],
      idUser: json["idUser"],
      name: json["name"],
      comment: json["comment"],
      date: json["date"],
      image: json["image"],
      rating: json["rating"]);
}
