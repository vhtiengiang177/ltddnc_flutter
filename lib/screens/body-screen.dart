import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/screens/account_screen.dart';
import 'package:ltddnc_flutter/screens/home_screen.dart';
import 'package:ltddnc_flutter/screens/product_detail_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

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
      // appBar: AppBar(
      //   title: SizedBox(
      //     height: 40,
      //     child: TextField(
      //         cursorRadius: Radius.circular(5.0),
      //         decoration: InputDecoration(
      //           prefixIcon: Icon(Icons.search),
      //           hintText: 'Tìm  kiếm...',
      //           fillColor: ColorCustom.inputColor,
      //           filled: true,
      //           enabledBorder: InputBorder.none,
      //         ),
      //         style: TextStyle(fontSize: 18),
      //         textInputAction: TextInputAction.search),
      //   ),
      // ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ColorCustom.primaryColor,
        iconSize: 28,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorCustom.selectedColor,
        unselectedItemColor: ColorCustom.unselectedColor,
        selectedIconTheme: IconThemeData(size: 35),
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
    if (selectedIndex == 2) {
      return AccountScreen();
    } else if (selectedIndex == 1) {
      // cart
    }
    return HomeScreen();
  }
}
