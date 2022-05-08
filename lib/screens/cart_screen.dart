import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/list_cart.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  int quantity = 1;
  bool _isInit = true;
  bool _isLoading = false;
  double _totalPrice = 0;

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
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorCustom.buttonSecondaryColor,
          centerTitle: true,
          title: Text("Giỏ hàng"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Image.asset(
                'assets/images/button/bin.png',
                width: 25,
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
                  color: ColorCustom.inputColor,
                  borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Tổng: ",
                          style: TextStyle(fontSize: 17),
                        ),
                        Text(
                          '${formatCurrency.format(_totalPrice)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ElevatedButton(
                        onPressed: () => {},
                        child: Row(
                          children: [
                            Text("Đặt hàng", style: TextStyle(fontSize: 18)),
                            Icon(Icons.arrow_forward)
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

  onChangeSelected() {
    double totalPrice = 0;
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.listCart.forEach((element) {
      if (element.selected == true) {
        totalPrice +=
            ((element.product?.unitPrice ?? 0) * (element.quantity ?? 0));
      }
    });
    setState(() {
      _totalPrice = totalPrice;
    });
  }
}
