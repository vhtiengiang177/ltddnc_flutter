import 'dart:convert';

UserAccountParams userAccountParamsFromJson(String str) => UserAccountParams.fromJson(json.decode(str));

String userAccountParamsToJson(UserAccountParams data) => json.encode(data.toJson());

class UserAccountParams {
  final String? email;
  final String? password;
  final String? name;
  final String? phone;
  final int? state;
  final int idRole;
  final String? image;

  const UserAccountParams(
      {this.name,
      this.email,
      this.phone,
      this.password,
      this.state,
      this.idRole = 1,
      this.image});

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phone": phone,
    "state": state,
    "idRole": idRole,
    "image": image
  };

    factory UserAccountParams.fromJson(Map<String, dynamic> json) => UserAccountParams(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phone: json["phone"],
    state: json["state"],
    idRole: json["idRole"],
    image: json["image"]
  );
}
