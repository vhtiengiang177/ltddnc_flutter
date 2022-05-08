import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/providers/favorite_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/screens/product_detail_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/auth-dialog.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return productProvider.listProduct.isNotEmpty == true
        ? Column(
            children: productProvider.listProduct
                .map(
                  (e) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                  product: e,
                                ))),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorCustom.inputColor,
                      ),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: e.image != null
                                ? Image.network(
                                    '${e.image}',
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    imageFailed,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    e.name ?? '',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${formatCurrency.format(e.unitPrice)}',
                                        style: TextStyle(
                                            color: ColorCustom.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Image.asset(
                                              'assets/images/button/shopping-cart.png',
                                              width: 24,
                                            ),
                                            onPressed: () async {
                                              final prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              final id =
                                                  prefs.getString('userId');
                                              if (id != null) {
                                                Cart cart = new Cart(
                                                    idUser: int.parse(id),
                                                    idProduct: e.id,
                                                    quantity: 1);
                                                cartProvider.addItem(cart).then(
                                                    (value) => {
                                                          Fluttertoast
                                                              .showToast(
                                                                  msg: value),
                                                          cartProvider.getCart(
                                                              int.parse(id))
                                                        });
                                              } else {
                                                showRequestLoginAlertDialog(
                                                    context);
                                              }
                                            },
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Text(
            "Không có sản phẩm",
            style: TextStyle(fontSize: 18),
          );
  }
}
