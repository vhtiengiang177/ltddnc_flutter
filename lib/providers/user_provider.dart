import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ltddnc_flutter/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User? user;

  UserProvider({this.user});

  static var client = http.Client();

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // User login(String email, String password) {
  //   return listUsers
  //       .firstWhere((e) => e.email == email && e.password == password);
  // }

  Future<void> register(User user) {
    print("register");
    return users.add({
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
      'password': user.password,
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> login(String email, String password) async {
    print("login");
    var userId;

    await users
        .where('email', isEqualTo: email)
        .where('password', isEqualTo: password)
        .limit(1)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((e) {
        final element = e.data();

        try {
          if (element is Map<String, dynamic>) {
            userId = e.id;
            user = new User(
                id: e.id,
                name: element['name'],
                email: element['email'],
                phone: element['phone'],
                password: element['password']);
          }
        } on Exception catch (e) {
          print(e.toString());
        }
      });
    });

    if (userId == null) {
      return;
    }

    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    if (user != null) {
      prefs.setString("userId", userId);
    }
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("userData");

    notifyListeners();
  }

  Future<void> test() async {
    print("test");
    var response = await http.Client().get(Uri.parse(
        'http://ac00-2402-800-6374-d586-3008-f9ae-915-30f1.ngrok.io/api/products'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
    }
  }
}
