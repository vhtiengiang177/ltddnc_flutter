import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/screens/body-screen.dart';
import 'package:provider/provider.dart';
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
          // if (snapshot.data == false) {
          //   Future.delayed(Duration(seconds: 2)).then((value) =>
          //       Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(builder: (context) => LoginScreen())));
          // }
          // if (snapshot.data == true) {
          //   Future.delayed(Duration(seconds: 2)).then((value) =>
          //       Navigator.of(context).pushReplacement(
          //           MaterialPageRoute(builder: (context) => BodyScreen())));
          // }
          Future.delayed(Duration(seconds: 2)).then((value) =>
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => BodyScreen())));
          return Scaffold(
              backgroundColor: Colors.white,
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/introduction/splash.gif'),
                  Text(
                    "Burger Bistro xin chào!",
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
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');
    var isAutoLogin = (id?.isNotEmpty == true);
    print("autoLogin: " + isAutoLogin.toString());
    if (isAutoLogin && userProvider.user == null) {
      userProvider.getUser(int.parse(id!));
    }

    return id?.isNotEmpty == true;
  }
}
