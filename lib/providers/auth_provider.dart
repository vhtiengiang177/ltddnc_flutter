import 'package:flutter/cupertino.dart';
import 'package:ltddnc_flutter/mock/user.dart';
import 'package:ltddnc_flutter/models/user.dart';

class UserProvider with ChangeNotifier {
  User login(String email, String password) {
    return listUsers.firstWhere((e) => e.email == email && e.password == password);
  }
}
