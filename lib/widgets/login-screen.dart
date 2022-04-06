import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/main.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constant.dart';
import 'package:ltddnc_flutter/widgets/register-screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _validateEmail = false;
  bool _validatePassword = false;
  bool _validateCredentials = false;
  String _emailErrorText = "Email can't be empty";
  String _passwordErrorText = "Password can't be empty";

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50,
          ),
          Align(
              alignment: Alignment.center,
              child: Image.asset('assets/icon.png')),
          Align(
            alignment: Alignment.center,
            child: Text("Login",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold,
                    color: ColorCustom.primaryColor,
                    fontSize: 40),
                textAlign: TextAlign.center),
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
                      errorText: _validateEmail ? _emailErrorText : null,
                      fillColor: ColorCustom.inputColor,
                      filled: true,
                      enabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10, right: 10)),
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
                    errorText: _validatePassword ? _passwordErrorText : null,
                    fillColor: ColorCustom.inputColor,
                    filled: true,
                    enabledBorder: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10, right: 10)),
                style: TextStyle(fontSize: 18)),
          ),
          Visibility(
            maintainSize: false,
            maintainState: true,
            visible: _validateCredentials,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Invalid Credentials',
                style: TextStyle(color: Colors.red[600], fontSize: 15),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _validateEmail = _email.text.isEmpty;
                        _validatePassword = _password.text.isEmpty;
                      });

                      if (_email.text.isNotEmpty != true) {
                        _emailErrorText = "Email can't be empty";
                        return;
                      } else if (_password.text.isNotEmpty != true) {
                        _passwordErrorText = "Password can't be empty";
                        return;
                      }
                      userProvider
                          .login(_email.text, _password.text)
                          .then((value) => {
                                if (userProvider.user != null)
                                  {
                                    _email.clear(),
                                    _password.clear(),
                                    _validateCredentials = false,
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyHomePage()))
                                  }
                                else
                                  {_validateCredentials = true}
                              });
                    },
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: ColorCustom.textPrimaryColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            ColorCustom.primaryColor),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'or',
                style: TextStyle(fontSize: 20),
              ),
              TextButton(
                onPressed: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()));

                  setState(() {
                    _email.text = result.toString();
                  });
                },
                child: Text(
                  'Register',
                  style: TextStyle(
                      fontSize: 20,
                      color: ColorCustom.primaryColor,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
