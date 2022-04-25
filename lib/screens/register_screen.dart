import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/models/user.dart';
import 'package:ltddnc_flutter/models/useraccountparams.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../shared/constants.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phonenumber = TextEditingController();
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _validateName = false;
  bool _validateEmail = false;
  bool _validatePhoneNumber = false;
  bool _validatePassword = false;
  bool _validateConfirmPassword = false;
  bool _validateCredentials = false;
  String _nameErrorText = "Vui lòng nhập tên";
  String _emailErrorText = "Vui lòng nhập email";
  String _phoneNumberErrorText = "Vui lòng nhập số điện thoại";
  String _passwordErrorText = "Vui lòng nhập mật khẩu";
  String _confirmPasswordErrorText = "Vui lòng nhập xác thực mật khẩu";

  String _errorText = "";

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/icon.png'),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Đăng ký",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorCustom.primaryColor,
                            fontSize: 40),
                        textAlign: TextAlign.center),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Tên: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _name,
                      maxLength: 30,
                      decoration: InputDecoration(
                          hintText: 'Nhập tên của bạn',
                          errorText: _validateName ? _nameErrorText : null,
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 18),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) => {
                        setState(() {
                          _validateName = _name.text.isEmpty;
                        })
                      },
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Email: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Focus(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
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
                          style: TextStyle(fontSize: 18),
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
                            _emailErrorText = "Định dạng email không hợp lệ";
                          } else
                            _validateEmail = false;
                        });
                      }
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Số điện thoại: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Focus(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
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
                        style: TextStyle(fontSize: 18),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    onFocusChange: (hasFocus) {
                      if (!hasFocus) {
                        setState(() {
                          if (_phonenumber.text.isEmpty) {
                            _validatePhoneNumber = _phonenumber.text.isEmpty;
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
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Mật khẩu: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Focus(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _password,
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: 'Nhập mật khẩu',
                            errorMaxLines: 2,
                            errorText:
                                _validatePassword ? _passwordErrorText : null,
                            fillColor: ColorCustom.inputColor,
                            filled: true,
                            enabledBorder: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                        style: TextStyle(fontSize: 18),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    onFocusChange: (hasFocus) {
                      var passwordValid = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                          .hasMatch(_password.text);

                      setState(() {
                        if (_password.text.isEmpty) {
                          _validatePassword = _password.text.isEmpty;
                          _passwordErrorText = "Vui lòng nhập mật khẩu";
                        } else if (!passwordValid) {
                          _validatePassword = true;
                          _passwordErrorText =
                              "Mật khẩu phải chứa ít nhất 1 ký tự hoa, ký tự thường, số và ký tự đặc biệt";
                        } else if (_password.text.isNotEmpty &&
                            _confirmpassword.text.isNotEmpty &&
                            _confirmpassword.text != _password.text) {
                          _validateConfirmPassword = true;
                          _confirmPasswordErrorText = "Mật khẩu không khớp";
                        } else if (_confirmpassword.text.isNotEmpty &&
                            _confirmpassword.text == _password.text)
                          _validateConfirmPassword = false;
                        else
                          _validatePassword = false;
                      });
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Nhập lại mật khẩu: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _confirmpassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Nhập lại mật khẩu',
                          errorText: _validateConfirmPassword
                              ? _confirmPasswordErrorText
                              : null,
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 18),
                      textInputAction: TextInputAction.done,
                      onChanged: (text) => {
                        setState(() {
                          if (text == "") {
                            _validateConfirmPassword =
                                _confirmpassword.text.isEmpty;
                            _confirmPasswordErrorText =
                                "Vui lòng nhập lại mật khẩu";
                          } else if (_password.text.isNotEmpty &&
                              _confirmpassword.text.isNotEmpty &&
                              _confirmpassword.text != _password.text) {
                            _validateConfirmPassword = true;
                            _confirmPasswordErrorText = "Mật khẩu không khớp";
                          } else {
                            _validateConfirmPassword =
                                _confirmpassword.text.isEmpty;
                          }
                        })
                      },
                    ),
                  ),
                  Visibility(
                    maintainSize: false,
                    maintainState: true,
                    visible: _validateCredentials,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        _errorText,
                        style: TextStyle(color: Colors.red[600], fontSize: 15),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(children: [
                      Expanded(
                          child: Consumer<UserProvider>(
                        builder: (context, value, _) => ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _validateName = _name.text.isEmpty;
                              _validateEmail = _email.text.isEmpty;
                              _validatePhoneNumber = _phonenumber.text.isEmpty;
                              _validatePassword = _password.text.isEmpty;
                              _validateConfirmPassword =
                                  _confirmpassword.text.isEmpty;
                            });

                            if (!_validateName &&
                                !_validateEmail &&
                                !_validatePhoneNumber &&
                                !_validatePassword &&
                                !_validateConfirmPassword) {
                              UserAccountParams newUser = new UserAccountParams(
                                  name: _name.text,
                                  email: _email.text,
                                  phone: _phonenumber.text,
                                  password: _password.text,
                                  state: 1,
                                  idRole: 1);
                              // User newUser = new User(
                              //     name: _name.text,
                              //     email: _email.text,
                              //     phone: _phonenumber.text,
                              //     password: _password.text);
                              await userProvider
                                  .register(newUser)
                                  .then((value) {
                                if (value != null) {
                                  _errorText = value;
                                  _validateCredentials = true;
                                }
                              });
                              Navigator.of(context).pop(_email.text);
                            }
                            return;
                          },
                          child: Text(
                            "ĐĂNG KÝ",
                            style: TextStyle(
                                color: ColorCustom.textPrimaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  ColorCustom.primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              )),
                        ),
                      )),
                    ]),
                  )
                ],
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(''),
                icon: Icon(Icons.arrow_back),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
