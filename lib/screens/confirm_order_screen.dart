import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/models/order_params.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/providers/order_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/alert-dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfirmOrderScreen extends StatefulWidget {
  ConfirmOrderScreen({Key? key, required this.listCartSelected})
      : super(key: key);
  final List<Cart> listCartSelected;
  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final _name = TextEditingController();
  final _phoneNumber = TextEditingController();
  final _address = TextEditingController();
  bool _validateName = false;
  bool _validatePhoneNumber = false;
  bool _validateAddress = false;
  String _nameErrorText = "Vui lòng nhập tên";
  String _phoneNumberErrorText = "Vui lòng nhập số điện thoại";
  String _addressErrorText = "Vui lòng nhập địa chỉ";
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  double _totalPrice = 0;
  int _totalQuantity = 0;

  @override
  void initState() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user != null) {
      userProvider.getUser(userProvider.user!.idAccount!);
    }
    setState(() {
      _name.text = userProvider.user!.name!;
      _phoneNumber.text = userProvider.user!.phone!;
      if (userProvider.user!.address != null) {
        _address.text = userProvider.user!.address!;
      }
      widget.listCartSelected.forEach((element) {
        _totalPrice += element.quantity! * element.product!.unitPrice!;
        _totalQuantity += element.quantity!;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: ColorCustom.buttonSecondaryColor,
          centerTitle: true,
          title: Text("Xác nhận đơn hàng"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          color: Colors.white70,
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
                              child: Row(
                                children: [
                                  Image.asset(
                                    "assets/images/button/location.png",
                                    width: 20,
                                    color: ColorCustom.primaryColor,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Địa chỉ nhận hàng",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Tên người nhận:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(4, 0, 8, 8),
                                    child: TextField(
                                        controller: _name,
                                        decoration: InputDecoration(
                                            hintText: 'Nhập tên người nhận',
                                            errorText: _validateName
                                                ? _nameErrorText
                                                : null,
                                            fillColor: ColorCustom.inputColor,
                                            filled: true,
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                8, 4, 8, 4)),
                                        style: TextStyle(fontSize: 14),
                                        textInputAction: TextInputAction.next),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "Số điện thoại: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Expanded(
                                  child: Focus(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          12.0, 0, 8.0, 0),
                                      child: TextField(
                                          controller: _phoneNumber,
                                          decoration: InputDecoration(
                                              hintText:
                                                  'Nhập số điện thoại của bạn',
                                              errorText: _validatePhoneNumber
                                                  ? _phoneNumberErrorText
                                                  : null,
                                              fillColor: ColorCustom.inputColor,
                                              filled: true,
                                              enabledBorder: InputBorder.none,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      8, 4, 8, 4)),
                                          style: TextStyle(fontSize: 14),
                                          textInputAction:
                                              TextInputAction.next),
                                    ),
                                    onFocusChange: (hasFocus) {
                                      if (!hasFocus) {
                                        setState(() {
                                          if (_phoneNumber.text.isEmpty) {
                                            _validatePhoneNumber =
                                                _phoneNumber.text.isEmpty;
                                            _phoneNumberErrorText =
                                                "Vui lòng nhập số điện thoại";
                                          }
                                          if (_phoneNumber.text.trim().length !=
                                              10) {
                                            _validatePhoneNumber = true;
                                            _phoneNumberErrorText =
                                                "Số điện thoại không hợp lệ";
                                          } else
                                            _validatePhoneNumber = false;
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 48,
                                ),
                                Text(
                                  "Địa chỉ: ",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        8.0, 8.0, 8.0, 0),
                                    child: TextField(
                                        controller: _address,
                                        decoration: InputDecoration(
                                            hintText: 'Nhập địa chỉ của bạn',
                                            errorText: _validateAddress
                                                ? _addressErrorText
                                                : null,
                                            fillColor: ColorCustom.inputColor,
                                            filled: true,
                                            enabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                8, 4, 8, 4)),
                                        style: TextStyle(fontSize: 14),
                                        textInputAction: TextInputAction.next),
                                  ),
                                ),
                              ],
                            ),
                          ]),
                        ),
                        Container(
                          color: Colors.white70,
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 4, 0, 12),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "assets/images/button/list.png",
                                      width: 20,
                                      color: ColorCustom.primaryColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Sản phẩm",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                              Column(
                                children: widget.listCartSelected
                                    .map(
                                      (e) => Container(
                                        height: 110,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                color: Color(0xFFA7A7A7)),
                                          ),
                                        ),
                                        clipBehavior: Clip.hardEdge,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Center(
                                              child: Container(
                                                width: 90,
                                                height: 90,
                                                clipBehavior: Clip.hardEdge,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: e.product!.image != null
                                                    ? Image.network(
                                                        '${e.product!.image}',
                                                        fit: BoxFit.cover,
                                                      )
                                                    : Image.asset(
                                                        imageFailed,
                                                        fit: BoxFit.cover,
                                                      ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    Text(
                                                      e.product!.name ?? "",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                        'x${e.quantity ?? 1}',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600],
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 4,
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: Text(
                                                        '${formatCurrency.format(e.product!.unitPrice ?? 0)}',
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Colors.grey[700],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                              Divider(
                                color: Color(0xFFA7A7A7),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Thành tiền (${_totalQuantity} sản phẩm):",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${formatCurrency.format(_totalPrice)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Palette.lightTheme.shade100,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 8,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Tổng thanh toán",
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(
                            '${formatCurrency.format(_totalPrice)}',
                            style: TextStyle(
                              color: ColorCustom.primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () => _requestOrder(widget.listCartSelected),
                      child: Text("Đặt hàng"),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              EdgeInsets.fromLTRB(25, 16, 25, 16))),
                    )
                  ]),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    showAlertDialog(context, "Bạn có chắc chắn quay lại không?",
            ["Đồng ý", "Huỷ"], "Thông báo")
        .then((value) => {
              if (value) {Navigator.of(context).pop(false)}
            });
    return new Future.value(false);
  }

  Future<void> _requestOrder(List<Cart> listCartSelected) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    // handle order
    if (_name.text.isEmpty ||
        _phoneNumber.text.isEmpty ||
        _address.text.isEmpty) {
      Fluttertoast.showToast(msg: "Vui lòng nhập địa chỉ giao hàng");
    } else if (_phoneNumber.text.trim().length != 10) {
      setState(() {
        _validatePhoneNumber = true;
        _phoneNumberErrorText = "Số điện thoại không hợp lệ";
      });
    } else {
      setState(() {
        _validateName = false;
        _validatePhoneNumber = false;
        _validateAddress = false;
      });
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('userId');
      if (id != null) {
        Order order = new Order(
            id: 0,
            state: 1,
            reviewState: 0,
            createDate: new DateTime.now().toIso8601String(),
            cancelDate: null,
            totalQuantity: _totalQuantity,
            totalProductPrice: _totalPrice,
            name: _name.text,
            phone: _phoneNumber.text,
            address: _address.text,
            idUser: int.parse(id));
        List<OrderDetail> lOrderDetail = [];
        listCartSelected.forEach((element) {
          OrderDetail orderDetail = OrderDetail(
              idOrder: 0,
              idProduct: element.idProduct,
              unitPrice: element.product!.unitPrice,
              quantity: element.quantity);
          lOrderDetail.add(orderDetail);
        });
        OrderParams orderParams =
            new OrderParams(order: order, listOrderDetail: lOrderDetail);
        orderProvider.createOrder(orderParams).then((value) => {
              if (value == 200)
                {
                  print("Create order success"),
                  cartProvider
                      .deleteItems(listCartSelected)
                      .then((value) async {
                    cartProvider.listCart
                        .removeWhere((element) => element.selected == true);
                    cartProvider.updateListCartLocal();
                  }),
                  showAlertDialog(context, "Đặt hàng thành công!", ["Đóng"],
                          "Thông báo")
                      .then((value) => {
                            if (value) {Navigator.of(context).pop(true)}
                          })
                }
              else
                {
                  print("Failed"),
                  showAlertDialog(
                          context, "Đặt hàng thất bại!", ["Huỷ"], "Thông báo")
                      .then((value) => {
                            if (value = false)
                              {Navigator.of(context).pop(false)}
                          })
                }
            });
      }
    }
  }
}
