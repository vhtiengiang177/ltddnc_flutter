import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  final _oldpassword = TextEditingController();
  final _newpassword = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _validateOldPassword = false;
  bool _validateNewPassword = false;
  bool _validateConfirmPassword = false;
  String _oldPasswordErrorText = "Vui lòng nhập mật khẩu cũ";
  String _newPasswordErrorText = "Vui lòng nhập mật khẩu mới";
  String _confirmPasswordErrorText = "Vui lòng nhập xác thực mật khẩu mới";

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
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
                    color: Colors.amber,
                    child: Row(children: [
                      IconButton(
                          onPressed: () => Navigator.of(context).pop(''),
                          icon: Icon(Icons.arrow_back)),
                      Text(
                        'Đổi mật khẩu',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: Text(
                              'Mật khẩu cũ: ',
                              style: TextStyle(fontSize: 20),
                            )),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _oldpassword,
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: 'Nhập mật khẩu cũ',
                                errorText: _validateOldPassword
                                    ? _oldPasswordErrorText
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
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: Text(
                              'Mật khẩu mới: ',
                              style: TextStyle(fontSize: 20),
                            )),
                        Focus(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _newpassword,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Nhập mật khẩu mới',
                                  errorText: _validateNewPassword
                                      ? _newPasswordErrorText
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
                            var passwordValid = RegExp(
                                    r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(_newpassword.text);

                            setState(() {
                              if (_newpassword.text.isEmpty) {
                                _validateNewPassword =
                                    _newpassword.text.isEmpty;
                                _newPasswordErrorText =
                                    "Vui lòng nhập mật khẩu mới";
                              } else if (!passwordValid) {
                                _validateNewPassword = false;
                                _newPasswordErrorText =
                                    "Mật khẩu phải chứa ít nhất 1 ký tự hoa, ký tự thường, số và ký tự đặc biệt";
                              }
                              if (_newpassword.text.isNotEmpty &&
                                  _confirmpassword.text.isNotEmpty &&
                                  _confirmpassword.text != _newpassword.text) {
                                _validateConfirmPassword = true;
                                _confirmPasswordErrorText =
                                    "Mật khẩu mới không khớp";
                              } else if (_confirmpassword.text.isNotEmpty &&
                                  _confirmpassword.text == _newpassword.text)
                                _validateConfirmPassword = false;
                            });
                          },
                        ),
                        const Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
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
                                contentPadding:
                                    EdgeInsets.only(left: 10, right: 10)),
                            style: TextStyle(fontSize: 18),
                            textInputAction: TextInputAction.done,
                            onChanged: (text) => {
                              setState(() {
                                if (text == "") {
                                  _validateConfirmPassword =
                                      _confirmpassword.text.isEmpty;
                                  _confirmPasswordErrorText =
                                      "Vui lòng nhập lại mật khẩu";
                                } else if (_newpassword.text.isNotEmpty &&
                                    _confirmpassword.text.isNotEmpty &&
                                    _confirmpassword.text !=
                                        _newpassword.text) {
                                  _validateConfirmPassword = true;
                                  _confirmPasswordErrorText =
                                      "Mật khẩu không khớp";
                                } else {
                                  _validateConfirmPassword =
                                      _confirmpassword.text.isEmpty;
                                }
                              })
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ]),
              ),
      ),
    );
  }
}
