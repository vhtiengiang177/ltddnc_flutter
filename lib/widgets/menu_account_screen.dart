import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/screens/change-password.dart';
import 'package:ltddnc_flutter/screens/home_screen.dart';
import 'package:ltddnc_flutter/screens/login_screen.dart';
import 'package:ltddnc_flutter/screens/user-info-screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return ColorCustom.buttonSelectedColor;
                    }
                    return ColorCustom.buttonSecondaryColor;
                  }),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 45))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/button/profile.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Quản lý tài khoản",
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserInfoScreen()));
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return ColorCustom.buttonSelectedColor;
                    }
                    return ColorCustom.buttonSecondaryColor;
                  }),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 45))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/button/password.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Cập nhật mật khẩu",
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()));
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return ColorCustom.buttonSelectedColor;
                    }
                    return ColorCustom.buttonSecondaryColor;
                  }),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 45))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/button/order.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Đơn hàng của bạn",
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
              onPressed: () {
                /* handle event */
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          child: Container(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return ColorCustom.buttonSelectedColor;
                    }
                    return ColorCustom.buttonSecondaryColor;
                  }),
                  minimumSize:
                      MaterialStateProperty.all(Size(double.infinity, 45))),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/button/logout.png',
                    width: 25,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Đăng xuất",
                    style: TextStyle(fontSize: 19),
                  ),
                ],
              ),
              onPressed: () {
                userProvider.logout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
          ),
        ),
      ],
    );
  }
}
