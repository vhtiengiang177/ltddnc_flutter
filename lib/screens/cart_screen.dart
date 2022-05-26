import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/screens/confirm_order_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/list_cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key, required this.isBack}) : super(key: key);

  final bool isBack;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  int quantity = 1;
  bool _isInit = true;
  bool _isLoading = false;
  double _totalPrice = 0;
  bool checkedAllItems = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final prefs = await SharedPreferences.getInstance();
      final cart = prefs.getString('cart');

      if (cart != null && cart.isNotEmpty == true) {
        Provider.of<CartProvider>(context, listen: false)
            .getCartLocal()
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } else {
        final id = prefs.getString('userId');
        Provider.of<CartProvider>(context, listen: false)
            .getCart(int.parse(id!))
            .then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      }

      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: widget.isBack,
          backgroundColor: ColorCustom.buttonSecondaryColor,
          centerTitle: true,
          title: Text("Giỏ hàng"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Image.asset(
                  'assets/images/button/bin.png',
                  width: 25,
                ),
                onPressed: () {
                  if (checkedAllItems == true) {
                    cartProvider
                        .deleteItems(cartProvider.listCart)
                        .then((value) async {
                      cartProvider.listCart
                          .removeRange(0, cartProvider.listCart.length);

                      setState(() {
                        _totalPrice = 0;
                      });

                      cartProvider.updateListCartLocal();
                      if (value.statusCode == 200) {
                        Fluttertoast.showToast(msg: value.body);
                      } else if (value.statusCode == 400) {
                        Fluttertoast.showToast(msg: value.body);
                      }
                      if (value.statusCode == 200) {
                        Fluttertoast.showToast(msg: value.body);
                      } else if (value.statusCode == 400) {
                        Fluttertoast.showToast(msg: value.body);
                      }
                    });
                  } else {
                    List<Cart> lCartDeleted = cartProvider.listCart
                        .where((element) => element.selected == true)
                        .toList();
                    if (lCartDeleted.length == 0) {
                      Fluttertoast.showToast(
                          msg: "Vui lòng chọn sản phẩm cần xoá");
                    } else {
                      cartProvider
                          .deleteItems(lCartDeleted)
                          .then((value) async {
                        cartProvider.listCart
                            .removeWhere((element) => element.selected == true);

                        setState(() {
                          _totalPrice = 0;
                        });

                        cartProvider.updateListCartLocal();

                        if (value.statusCode == 200) {
                          Fluttertoast.showToast(msg: value.body);
                        } else if (value.statusCode == 400) {
                          Fluttertoast.showToast(msg: value.body);
                        }
                      });
                    }
                  }
                },
              ),
            )
          ]),
      body: SafeArea(
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: _isLoading
                  ? Container(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    )
                  : ListCart(
                      onChangeSelected: onChangeSelected,
                    ),
            ),
            Container(
              alignment: Alignment.center,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 100,
                      padding: EdgeInsets.zero,
                      child: CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          "Tất cả",
                        ),
                        checkColor: Colors.black,
                        value: checkedAllItems,
                        onChanged: (value) => {
                          setState(() {
                            checkedAllItems = value ?? false;
                            onChangeSelected(checkedAllItems);
                          }),
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                    ),
                    Text('${formatCurrency.format(_totalPrice)}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    ElevatedButton(
                        onPressed: () async {
                          List<Cart> lCartSeleted = cartProvider.listCart
                              .where((element) => element.selected == true)
                              .toList();
                          if (lCartSeleted.length == 0) {
                            Fluttertoast.showToast(
                                msg: "Vui lòng chọn sản phẩm cần đặt hàng");
                          } else {
                            bool result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ConfirmOrderScreen(
                                          listCartSelected: lCartSeleted,
                                        )));
                            if (result == true) {
                              setState(() {
                                _totalPrice = 0;
                                checkedAllItems = false;
                              });
                            } else {
                              onChangeSelected(null);
                            }
                          }
                        },
                        child: Row(
                          children: [
                            Text("Đặt hàng", style: TextStyle(fontSize: 18))
                          ],
                        ))
                  ],
                ),
              ),
            )
          ])
        ]),
      ),
    );
  }

  onChangeSelected(bool? allChecked) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    double totalPrice = 0;
    if (allChecked != null) {
      cartProvider.listCart.forEach((element) {
        element.selected = allChecked;
        totalPrice = allChecked
            ? totalPrice +
                ((element.product?.unitPrice ?? 0) * (element.quantity ?? 0))
            : 0;
      });
    } else {
      bool isAllChecked = true;
      cartProvider.listCart.forEach((element) {
        if (element.selected == true) {
          totalPrice +=
              ((element.product?.unitPrice ?? 0) * (element.quantity ?? 0));
        } else {
          isAllChecked = false;
        }
      });
      setState(() {
        if (isAllChecked != checkedAllItems) checkedAllItems = !checkedAllItems;
      });
    }
    setState(() {
      _totalPrice = totalPrice;
    });
  }

  // void onCheckboxAllItemsChanged(bool? value) {
  //   Provider.of<CartProvider>(context).listCart.forEach((element) {
  //     element.selected = value ?? false;
  //   });
  // }
}
