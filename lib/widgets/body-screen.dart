import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/screens/account-screen.dart';
import 'package:ltddnc_flutter/screens/home-screen.dart';
import 'package:ltddnc_flutter/shared/constant.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search...',
              fillColor: ColorCustom.inputColor,
              filled: true,
              enabledBorder: InputBorder.none,
            ),
            style: TextStyle(fontSize: 18),
            textInputAction: TextInputAction.search),
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "")
        ],
        onTap: (index) {
          this.onTapBottomNavigationBarHandler(index);
        },
      ),
    );
  }

  void onTapBottomNavigationBarHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }

  Widget getBody() {
    if (selectedIndex == 3) {
      return AccountScreen();
    }
    return HomeScreen();
  }
}
