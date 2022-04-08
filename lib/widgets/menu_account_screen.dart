import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/screens/login_screen.dart';
import 'package:provider/provider.dart';

class MenuAccountScreen extends StatefulWidget {
  const MenuAccountScreen({Key? key}) : super(key: key);

  @override
  State<MenuAccountScreen> createState() => _MenuAccountScreenState();
}

class _MenuAccountScreenState extends State<MenuAccountScreen> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ElevatedButton(
      child: Text("Đăng xuất"),
      onPressed: () {
        userProvider.logout();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      },
    );
  }
}
