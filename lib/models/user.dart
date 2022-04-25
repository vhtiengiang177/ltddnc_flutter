import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());
class User {
  final int? idAccount;
  final String? name;
  final String? phone;
  final String? address;
  const User({this.idAccount, this.name, this.phone, this.address});

  Map<String, dynamic> toJson() => {
    "id": idAccount,
    "name": name,
    "phone": phone,
    "address": address
  };

    factory User.fromJson(Map<String, dynamic> json) => User(
    idAccount: json["idAccount"],
    name: json["name"],
    phone: json["phone"],
    address: json["address"]
  );
}


// class User {
//   final String? id;
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? password;

//   const User({this.id, this.name, this.email, this.phone, this.password});
// }