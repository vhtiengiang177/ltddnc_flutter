import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/models/user.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../shared/constant.dart';

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
  String _nameErrorText = "Name can't be empty";
  String _emailErrorText = "Email can't be empty";
  String _phoneNumberErrorText = "Phone number can't be empty";
  String _passwordErrorText = "Password can't be empty";
  String _confirmPasswordErrorText = "Confirm password can't be empty";

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
                    child: Text("Register",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            color: ColorCustom.primaryColor,
                            fontSize: 40),
                        textAlign: TextAlign.center),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Name: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _name,
                      decoration: InputDecoration(
                          hintText: 'Enter your name',
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
                          decoration: InputDecoration(
                              hintText: 'Enter your email',
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
                            _emailErrorText = "Email can't be empty";
                          } else if (!emailValid) {
                            _validateEmail = !emailValid;
                            _emailErrorText = "Invalid email format";
                          } else
                            _validateEmail = false;
                        });
                      }
                    },
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Phone number: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _phonenumber,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          hintText: 'Enter your phone number',
                          errorText: _validatePhoneNumber
                              ? _phoneNumberErrorText
                              : null,
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 18),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) => {
                        setState(() {
                          _validatePhoneNumber = _phonenumber.text.isEmpty;
                        })
                      },
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Password: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Enter your password',
                          errorText:
                              _validatePassword ? _passwordErrorText : null,
                          fillColor: ColorCustom.inputColor,
                          filled: true,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(left: 10, right: 10)),
                      style: TextStyle(fontSize: 18),
                      textInputAction: TextInputAction.next,
                      onChanged: (text) => {
                        setState(() {
                          _validatePassword = _password.text.isEmpty;
                          _passwordErrorText = "Password can't be empty";
                          _confirmPasswordErrorText =
                              "Confirm password can't be empty";
                          if (_password.text.isNotEmpty &&
                              _confirmpassword.text.isNotEmpty &&
                              _confirmpassword.text != _password.text) {
                            _validateConfirmPassword = true;
                            _confirmPasswordErrorText = "Password mismatch";
                          } else if (_confirmpassword.text.isNotEmpty &&
                              _confirmpassword.text == _password.text)
                            _validateConfirmPassword = false;
                        })
                      },
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Confirm Password: ',
                        style: TextStyle(fontSize: 20),
                      )),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _confirmpassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Confirm your password',
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
                                "Confirm password can't be empty";
                          } else if (_password.text.isNotEmpty &&
                              _confirmpassword.text.isNotEmpty &&
                              _confirmpassword.text != _password.text) {
                            _validateConfirmPassword = true;
                            _confirmPasswordErrorText = "Password mismatch";
                          } else {
                            _validateConfirmPassword =
                                _confirmpassword.text.isEmpty;
                          }
                        })
                      },
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
                              User newUser = new User(
                                  name: _name.text,
                                  email: _email.text,
                                  phone: _phonenumber.text,
                                  password: _password.text);
                              await userProvider.register(newUser);
                              Navigator.of(context).pop(_email.text);
                            }
                            return;
                          },
                          child: Text(
                            "REGISTER",
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
