import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/alert-dialog.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';
import 'package:provider/provider.dart';

class ListCart extends StatefulWidget {
  const ListCart({Key? key, required this.onChangeSelected}) : super(key: key);

  final Function onChangeSelected;
  @override
  State<ListCart> createState() => _ListCartState();
}

class _ListCartState extends State<ListCart> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  List<Cart> listCartSelected = [];

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.listCart.length > 0
        ? SingleChildScrollView(
            child: Column(
                children: cartProvider.listCart
                    .map((e) => Padding(
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
                                Center(
                                  child: Checkbox(
                                      checkColor: Colors.black,
                                      value: e.selected,
                                      onChanged: (value) => {
                                            setState(() {
                                              e.selected = value;
                                            }),
                                            widget.onChangeSelected(null),
                                          }),
                                ),
                                Center(
                                  child: Container(
                                    width: 110,
                                    height: 110,
                                    child: e.product?.image != null
                                        ? Image.network(
                                            '${e.product?.image}',
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          e.product?.name ?? "",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${formatCurrency.format(e.product?.unitPrice ?? 0)}',
                                          style: TextStyle(
                                              color:
                                                  ColorCustom.textPrimaryColor,
                                              fontSize: 16),
                                        ),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Quantity(
                                            onChangeQuantity: onChangeQuantity,
                                            quantity: e.quantity ?? 1,
                                            index: cartProvider.listCart
                                                .indexOf(e),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList()),
          )
        : Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image.asset(
                'assets/images/icon/empty-cart.png',
                width: 90,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Chưa có sản phẩm trong giỏ hàng",
                style: TextStyle(fontSize: 18),
              ),
            ],
          );
  }

  bool onChangeQuantity(bool isIncrease, int? index) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (index != null) {
      if (isIncrease) {
        cartProvider.onQuantityChanged(context, index, isInscrease: isIncrease);
      } else if (!isIncrease) {
        cartProvider.onQuantityChanged(context, index, isInscrease: isIncrease);
      }
    }

    widget.onChangeSelected(null);
    return true;
  }
}
