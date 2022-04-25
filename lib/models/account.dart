import 'dart:convert';

Account accountParamsFromJson(String str) => Account.fromJson(json.decode(str));

String accountParamsToJson(Account data) => json.encode(data.toJson());

class Account {
  final String? id;
  final String? email;
  final String? password;
  const Account({this.id, this.email, this.password});

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password
  };

    factory Account.fromJson(Map<String, dynamic> json) => Account(
    email: json["email"],
    password: json["password"]
  );
}
