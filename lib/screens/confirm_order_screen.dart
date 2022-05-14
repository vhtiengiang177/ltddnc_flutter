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
  final _name = TextEditingController(text: "Vo Hong Tien Giang");
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Tên người nhận:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
                  child: TextField(
                      controller: _name,
                      decoration: InputDecoration(
                          hintText: 'Nhập tên người nhận',
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 16),
                      textInputAction: TextInputAction.next),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                "Số điện thoại: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _phoneNumbere,
                      decoration: InputDecoration(
                          hintText: 'Nhập số điện thoại của bạn',
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 16),
                      textInputAction: TextInputAction.next),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 55,
              ),
              Text(
                "Địa chỉ: ",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                      controller: _address,
                      decoration: InputDecoration(
                          hintText: 'Nhập địa chỉ của bạn',
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 16),
                      textInputAction: TextInputAction.next),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
