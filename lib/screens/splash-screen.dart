import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constant.dart';

class SlashScreen extends StatelessWidget {
  const SlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/introduction/splash.gif'),
            Text("Loading...", style: TextStyle(fontSize: 25, color: ColorCustom.primaryColor, ),)
          ],
        ));
  }
}
