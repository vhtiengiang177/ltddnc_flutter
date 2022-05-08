import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/providers/favorite_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';
import 'package:provider/provider.dart';
import 'package:ltddnc_flutter/widgets/auth-dialog.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product}  )
      : super(key: key);
  final Product product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  String iconHeart ='heart-regular';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: ListView(
              children: [
                Container(
                  height: 250,
                  child: widget.product.image != null
                      ? Image.network(
                          '${widget.product.image}',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          imageFailed,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 8, left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.name}',
                        style: TextStyle(
                            color: ColorCustom.textPrimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 50,
                        child: favoriteProvider.listProduct.where((e) => e.id == widget.product.id).length > 0
                            ? IconButton(
                          icon: Image.asset(
                            'assets/images/button/heart.png',
                            width: 30,
                            color: favoriteProvider.listProduct.where((e) => e.id == widget.product.id).length > 0
                                ? Colors.red
                                : Colors.black,
                          ),
                          onPressed: () => {
                            setState(
                                  () {
                                      iconHeart = 'heart-regular';
                                      favoriteProvider.removeFavorite(userProvider.user?.idAccount,widget.product);
                              },
                            )

                          },

                        )
                            : IconButton(

                          icon: Image.asset(
                            'assets/images/button/heart-regular.png',
                            width: 30,
                            color: favoriteProvider.listProduct.where((e) => e.id == widget.product.id).length > 0
                                ? Colors.red
                                : Colors.black,
                          ),
                          onPressed: () => {
                            setState(
                                  () {
                                    iconHeart = 'heart';
                                    favoriteProvider.addFavorite(userProvider.user?.idAccount,widget.product);
                              },
                            )
                            /* handle favorite */

                          },

                        )
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '${formatCurrency.format(widget.product.unitPrice)}',
                    style: TextStyle(
                        color: ColorCustom.textPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: Text(
                    widget.product.description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: TextStyle(
                        fontSize: 16, color: ColorCustom.secondaryColor),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                height: 60,
                decoration: BoxDecoration(
                    color: ColorCustom.inputColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Quantity(
                        onChangeQuantity: onChangeQuantity,
                        quantity: 1,
                      ),
                      ElevatedButton(
                          onPressed: () => {},
                          child: Text("Thêm vào giỏ",
                              style: TextStyle(fontSize: 18)))
                    ],
                  ),
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(190, 149, 149, 149)),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(''),
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void onChangeQuantity(bool isIncrease, int? index) {
    quantity += isIncrease ? 1 : -1;
    print("quantity" + quantity.toString());
  }
}
