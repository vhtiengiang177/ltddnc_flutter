import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  final int? idAccount;
  final String? name;
  final String? image;
  final String? phone;
  final String? address;
  final String? email;
  const User({this.idAccount, this.name, this.image, this.phone, this.address, this.email});

  Map<String, dynamic> toJson() => {
        "idAccount": idAccount,
        "name": name,
        "image": image,
        "phone": phone,
        "address": address,
        "email": email
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
      idAccount: json["idAccount"],
      name: json["name"],
      image: json["image"],
      phone: json["phone"],
      address: json["address"],
      email: json["email"]);
}


// class User {
//   final String? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? password;

//   const User({this.id, this.name, this.email, this.phone, this.password});
// }