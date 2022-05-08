import 'package:flutter/cupertino.dart';
import 'package:ltddnc_flutter/models/account.dart';
import 'package:ltddnc_flutter/models/user.dart';
import 'package:ltddnc_flutter/models/useraccountparams.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UserProvider with ChangeNotifier {
  User? user;

  UserProvider({this.user});

  static var client = http.Client();
  final routeAPIAccount = "/accounts";
  final routeAPIUser = "/users";
  final routeAPICart = "/carts";

  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  // User login(String email, String password) {
  //   return listUsers
  //       .firstWhere((e) => e.email == email && e.password == password);
  // }

  // Future<void> register(User user) {
  //   print("register");
  //   return users.add({
  //     'name': user.name,
  //     'email': user.email,
  //     'phone': user.phone,
  //     'password': user.password,
  //   }).catchError((error) => print("Failed to add user: $error"));
  // }

  // Future<void> login(String email, String password) async {
  //   print("login");
  //   var userId;

  //   await users
  //       .where('email', isEqualTo: email)
  //       .where('password', isEqualTo: password)
  //       .limit(1)
  //       .get()
  //       .then((querySnapshot) {
  //     querySnapshot.docs.forEach((e) {
  //       final element = e.data();

  //       try {
  //         if (element is Map<String, dynamic>) {
  //           userId = e.id;
  //           user = new User(
  //               id: e.id,
  //               name: element['name'],
  //               email: element['email'],
  //               phone: element['phone'],
  //               password: element['password']);
  //         }
  //       } on Exception catch (e) {
  //         print(e.toString());
  //       }
  //     });
  //   });

  //   if (userId == null) {
  //     return;
  //   }

  //   notifyListeners();

  //   final prefs = await SharedPreferences.getInstance();
  //   if (user != null) {
  //     prefs.setString("userId", userId);
  //   }
  // }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("userId");
    if (prefs.getString("cart") != null) {
      await updateCart(prefs.getString("cart")!);
    }
    prefs.remove("cart");

    notifyListeners();
  }

  // Future<void> test() async {
  //   print("test");
  //   var response = await http.Client().get(Uri.parse(
  //       'http://ac00-2402-800-6374-d586-3008-f9ae-915-30f1.ngrok.io/api/products'));
  //   if (response.statusCode == 200) {
  //     var jsonString = response.body;
  //     print(jsonString);
  //   }
  // }

  Future<String?> register(UserAccountParams user) async {
    print(userAccountParamsToJson(user));
    var response = await client.post(
        Uri.parse(apiHost + routeAPIAccount + "/CreateAccount"),
        body: userAccountParamsToJson(user),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      var jsonString = response.body;
      print(jsonString);
      return null;
    } else if (response.statusCode == 400) {
      print("register failed");
      return response.body.toString();
    }
    return "Lỗi không xác định";
  }

  Future<String?> login(Account account) async {
    print("Login");
    print(accountParamsToJson(account));
    var response = await client.post(
        Uri.parse(apiHost + routeAPIAccount + "/login"),
        body: accountParamsToJson(account),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      User userResponse = userFromJson(response.body);
      print(user);
      final prefs = await SharedPreferences.getInstance();
      user = userResponse;
      prefs.setString("userId", userResponse.idAccount.toString());

      notifyListeners();
      return null;
    } else if (response.statusCode == 400) {
      user = null;
      print("login failed");
      return response.body;
    }

    return "Lỗi không xác định";
  }

  Future<String?> updateInfo(User userParams) async {
    print("updateInfo");
    print(userToJson(userParams));
    var response = await client.patch(
        Uri.parse(apiHost + routeAPIAccount + "/updateaccount"),
        body: userToJson(userParams),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);

    print(response.body);
    if (response.statusCode == 200) {
      user = userParams;

      notifyListeners();
      return response.body;
    } else if (response.statusCode == 400) {
      user = null;
      print("updateInfo failed");
      return response.body;
    }

    return "Lỗi không xác định";
  }

  Future<String?> getUser(int accountId) async {
    print("getUser: " + accountId.toString());
    var response = await client.get(
        Uri.parse(
            apiHost + routeAPIAccount + "/getuser/" + accountId.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      User userResponse = userFromJson(response.body);
      user = userResponse;
      print(user);
      return null;
    } else if (response.statusCode == 400) {
      user = null;
      print("getuser failed");
      return response.body;
    }

    return "Lỗi không xác định";
  }

  Future<void> updateCart(String request) async {
    print("Update Cart Before User Logout");
    var response = await client.post(
        Uri.parse(apiHost + routeAPICart + "/UpdateCart"),
        body: request,
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {

    } 
    else if (response.statusCode == 400) {
      print("Failed");
    }
  }
}
