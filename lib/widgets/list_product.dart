import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/screens/product_detail_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/auth-dialog.dart';
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 3.0),
                      child: Container(
                        height: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[200],
                        ),
                        clipBehavior: Clip.hardEdge,
                        margin: EdgeInsets.only(bottom: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      e.name ?? "",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      '${formatCurrency.format(e.unitPrice ?? 0)}',
                                      style: TextStyle(
                                          color: ColorCustom.textPrimaryColor,
                                          fontSize: 16),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomRight,
                                        child: IconButton(
                                          icon: Image.asset(
                                            'assets/images/button/shopping-cart-add.png',
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
                                                        Fluttertoast.showToast(
                                                            msg: value),
                                                        cartProvider.getCart(
                                                            int.parse(id))
                                                      });
                                            } else {
                                              showRequestLoginAlertDialog(
                                                  context);
                                            }
                                          },
                                          splashColor: Colors.transparent,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
