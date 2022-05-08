import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/screens/account_screen.dart';
import 'package:ltddnc_flutter/screens/cart_screen.dart';
import 'package:ltddnc_flutter/screens/favorite_screen.dart';
import 'package:ltddnc_flutter/screens/home_screen.dart';
import 'package:ltddnc_flutter/widgets/auth-dialog.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BodyScreen extends StatefulWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  State<BodyScreen> createState() => _BodyScreenState();
}

class _BodyScreenState extends State<BodyScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
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
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorCustom.selectedColor,
        unselectedItemColor: ColorCustom.unselectedColor,
        selectedIconTheme: IconThemeData(size: 30),
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/button/home.png')),
              label: "Home"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/button/heart.png')),
              label: "Favorite"),
          BottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage('assets/images/button/shopping-cart.png')),
              label: "Cart"),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/images/button/user.png')),
              label: "User")
        ],
        onTap: (index) async {
          print("bottom navigation: index = " + index.toString());
          if ((index == 1 || index == 2 || index == 3) &&
              await userProvider.autoLogin() == false) {
            showRequestLoginAlertDialog(context);
          } else {
            this.onTapBottomNavigationBarHandler(index);
          }
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
    } else if (selectedIndex == 2) {
      return CartScreen();
    }
    else if (selectedIndex == 1) {
      return FavoriteScreen();
    }
    return HomeScreen();
  }


}
