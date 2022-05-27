import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ltddnc_flutter/models/user.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  const UserInfoScreen({Key? key}) : super(key: key);

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final ImagePicker _picker = ImagePicker();

  String avatarUrl = '';
  bool _isInit = true;
  bool _isLoading = false;
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phonenumber = TextEditingController();
  final _address = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePhoneNumber = false;
  String _nameErrorText = "Vui lòng nhập tên";
  String _emailErrorText = "Vui lòng nhập email";
  String _phoneNumberErrorText = "Vui lòng nhập số điện thoại";

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final userProvider = Provider.of<UserProvider>(context, listen: false);
      setState(() {
        _name.text = userProvider.user?.name ?? "";
        _email.text = userProvider.user?.email ?? "";
        _phonenumber.text = userProvider.user?.phone ?? "";
        _address.text = userProvider.user?.address ?? "";
        avatarUrl = userProvider.user?.image ?? '';
      });
      // handle
      Future.delayed(Duration(seconds: 1)).then((_) => {
            setState(() {
              _isLoading = false;
            })
          });

      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(children: [
                  Container(
                    height: 60,
                    color: ColorCustom.buttonSecondaryColor,
                    child: Row(children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(''),
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        'Tài khoản',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 2),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CircleAvatar(
                              backgroundImage: avatarUrl.isNotEmpty == true
                                  ? NetworkImage(avatarUrl) as ImageProvider
                                  : AssetImage(
                                      'assets/images/profile-default.jpg'),
                            ),
                          ),
                        ),
                        Center(
                            child: ElevatedButton(
                          onPressed: _updateAvatar,
                          child: Text("Đổi ảnh đại diện"),
                        )),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0, top: 20.0),
                            child: Text(
                              'Tên: ',
                              style: TextStyle(fontSize: 18),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                              controller: _name,
                              maxLength: 30,
                              decoration: InputDecoration(
                                  hintText: 'Nhập tên của bạn',
                                  errorText:
                                      _validateName ? _nameErrorText : null,
                                  fillColor: ColorCustom.inputColor,
                                  filled: true,
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 10, right: 10)),
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.next),
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: Text(
                              'Email: ',
                              style: TextStyle(fontSize: 18),
                            )),
                        Focus(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                                controller: _email,
                                maxLength: 30,
                                decoration: InputDecoration(
                                    hintText: 'Nhập email của bạn',
                                    errorText:
                                        _validateEmail ? _emailErrorText : null,
                                    fillColor: ColorCustom.inputColor,
                                    filled: true,
                                    enabledBorder: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.only(left: 10, right: 10)),
                                style: TextStyle(fontSize: 16),
                                textInputAction: TextInputAction.next),
                          ),
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              var emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(_email.text);
                              setState(() {
                                if (_email.text.trim() == "") {
                                  _emailErrorText = "Vui lòng nhập email";
                                } else if (!emailValid) {
                                  _validateEmail = !emailValid;
                                  _emailErrorText =
                                      "Định dạng email không hợp lệ";
                                } else
                                  _validateEmail = false;
                              });
                            }
                          },
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: Text(
                              'Số điện thoại: ',
                              style: TextStyle(fontSize: 18),
                            )),
                        Focus(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: TextField(
                              controller: _phonenumber,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  hintText: 'Nhập số điện thoại của bạn',
                                  errorText: _validatePhoneNumber
                                      ? _phoneNumberErrorText
                                      : null,
                                  fillColor: ColorCustom.inputColor,
                                  filled: true,
                                  enabledBorder: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 10, right: 10)),
                              style: TextStyle(fontSize: 16),
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          onFocusChange: (hasFocus) {
                            if (!hasFocus) {
                              setState(() {
                                if (_phonenumber.text.isEmpty) {
                                  _validatePhoneNumber =
                                      _phonenumber.text.isEmpty;
                                  _phoneNumberErrorText =
                                      "Vui lòng nhập số điện thoại";
                                }
                                if (_phonenumber.text.trim().length != 10) {
                                  _validatePhoneNumber = true;
                                  _phoneNumberErrorText =
                                      "Số điện thoại không hợp lệ";
                                } else
                                  _validatePhoneNumber = false;
                              });
                            }
                          },
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0, top: 20.0),
                            child: Text(
                              'Địa chỉ: ',
                              style: TextStyle(fontSize: 18),
                            )),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            controller: _address,
                            keyboardType: TextInputType.multiline,
                            maxLines: 3,
                            decoration: InputDecoration(
                                hintText: 'Nhập địa chỉ của bạn',
                                errorText:
                                    _validateName ? _nameErrorText : null,
                                fillColor: ColorCustom.inputColor,
                                filled: true,
                                enabledBorder: InputBorder.none,
                                contentPadding: EdgeInsets.all(10)),
                            style: TextStyle(fontSize: 16),
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: (() {
                                    User userParams = User(
                                        idAccount: userProvider.user?.idAccount,
                                        name: _name.text,
                                        image: avatarUrl,
                                        phone: _phonenumber.text,
                                        address: _address.text,
                                        email: _email.text);
                                    userProvider
                                        .updateInfo(userParams)
                                        .then((value) {
                                      if (value != null) {
                                        Fluttertoast.showToast(msg: value);
                                      }
                                    });
                                  }),
                                  child: Text("Lưu thông tin"),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
      ),
    );
  }

  Future<void> _updateAvatar() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final sp = await SharedPreferences.getInstance();
      final userId = sp.getString('userId');
      final ref = FirebaseStorage.instance
          .ref('profilePics/${userId ?? 'Unknown'}/${image.name}');

      EasyLoading.show();

      try {
        final snapshot = await ref.putFile(
          File(image.path),
        );

        if (snapshot.state == TaskState.success) {
          final newUrl = await snapshot.ref.getDownloadURL();
          setState(() {
            avatarUrl = newUrl;
          });

          print(newUrl);
        }
      } catch (e) {
        print(e.toString());
      }

      EasyLoading.dismiss();
    }
  }
}
