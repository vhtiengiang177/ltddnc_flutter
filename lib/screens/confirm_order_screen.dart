import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrderScreen extends StatefulWidget {
  ConfirmOrderScreen({Key? key, required this.listCart}) : super(key: key);
  final List<Cart> listCart;
  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final _name = TextEditingController();
  final _phoneNumbere = TextEditingController();
  final _address = TextEditingController();

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user == null) {
      userProvider.getUser(userProvider.user!.idAccount!);
    }

    setState(() {
      _name.text = userProvider.user!.name!;
      _phoneNumbere.text = userProvider.user!.phone!;
      if (userProvider.user!.address != null) {
        _address.text = userProvider.user!.address!;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorCustom.buttonSecondaryColor,
        centerTitle: true,
        title: Text("Xác nhận đơn hàng"),
      ),
      body: Container(
        color: ColorCustom.buttonSecondaryColor,
        margin: EdgeInsets.all(8),
        height: 200,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tên người nhận: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              )
            ],
          ),
          Row(
            children: [Text("SĐT: "), Text("0123456789")],
          ),
          Row(
            children: [Text("Địa chỉ: "), Text("")],
          ),
        ]),
      ),
    );
  }
}
