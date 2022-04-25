import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/menu_account_screen.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return ListView(
      children: [
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 70),
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorCustom.primaryColor),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 75,
                      ),
                      Text(
                        userProvider.user?.name ?? "",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: 130,
                    height: 130,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/profile-default.jpg'),
                    ),
                  ),
                )
              ],
            )),
        MenuAccountScreen()
      ],
    );
  }
}
