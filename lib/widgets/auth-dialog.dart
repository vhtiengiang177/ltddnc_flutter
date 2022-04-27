import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/screens/login_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

showRequestLoginAlertDialog(BuildContext context) {
  AlertDialog dialogRequestLogin = AlertDialog(
    contentPadding: EdgeInsets.fromLTRB(24, 24, 20, 0),
    buttonPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 0),
    title: Row(
      children: [
        Image.asset(
          'assets/images/button/bell.png',
          width: 20,
          height: 20,
        ),
        SizedBox(
          width: 10,
        ),
        Text("Thông báo"),
      ],
    ),
    content: Text("Vui lòng đăng nhập để thực hiện chức năng này."),
    actions: [
      Row(
        children: [
          Expanded(
            child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      ColorCustom.buttonSecondaryColor),
                ),
                child: Text("HUỶ"),
                onPressed: () {
                  Navigator.of(context).pop(false);
                }),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: ElevatedButton(
                child: Text("ĐĂNG NHẬP"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                }),
          ),
        ],
      )
    ],
  );

  Future<dynamic> futureValue = showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialogRequestLogin;
      });

  futureValue.then((value) {
    if (value == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  });
}
