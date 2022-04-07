import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/main.dart';
import 'package:ltddnc_flutter/screens/home-screen.dart';
import 'package:ltddnc_flutter/shared/constant.dart';
import 'package:ltddnc_flutter/widgets/body-screen.dart';
import 'package:ltddnc_flutter/widgets/login-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlashScreen extends StatefulWidget {
  const SlashScreen({Key? key}) : super(key: key);

  @override
  State<SlashScreen> createState() => _SlashScreenState();
}

class _SlashScreenState extends State<SlashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.data == false) {
            Future.delayed(Duration(seconds: 2)).then((value) =>
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen())));
          }
          if (snapshot.data == true) {
            Future.delayed(Duration(seconds: 2)).then((value) =>
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BodyScreen())));
          }
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/introduction/splash.gif'),
                  Text(
                    "Loading...",
                    style: TextStyle(
                      fontSize: 25,
                      color: ColorCustom.primaryColor,
                    ),
                  )
                ],
              ));
        });
  }

  Future<bool> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();

    final id = prefs.getString('userId');

    return id?.isNotEmpty == true;
  }
}
