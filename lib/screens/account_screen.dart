import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/widgets/menu_account_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [MenuAccountScreen()],
    );
  }
}
