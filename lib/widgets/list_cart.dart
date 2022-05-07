import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
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
        ? Column(
            children: cartProvider.listCart
                .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                            Checkbox(
                                checkColor: Colors.black,
                                value: e.selected,
                                onChanged: (value) => {
                                      setState(() {
                                        e.selected = value;
                                      }),
                                      widget.onChangeSelected(),
                                    }),
                            Container(
                              width: 100,
                              height: 100,
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
                                      style: TextStyle(fontSize: 22),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${formatCurrency.format(e.product?.unitPrice ?? 0)}',
                                          style: TextStyle(
                                              color: ColorCustom.primaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Quantity(
                                            onChangeQuantity: onChangeQuantity,
                                            quantity: e.quantity ?? 1,
                                            index: cartProvider.listCart
                                                .indexOf(e),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ))
                .toList())
        : Text(
            "Không có sản phẩm trong giỏ, mua sắm ngay",
            style: TextStyle(fontSize: 18),
          );
  }

  void onChangeQuantity(bool isIncrease, int? index) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    if (index != null) {
      int quantity = cartProvider.listCart.elementAt(index).quantity!;
      cartProvider.listCart.elementAt(index).quantity =
          isIncrease ? quantity + 1 : quantity - 1;
    }
    cartProvider.onQuantityChanged();
    widget.onChangeSelected();
  }
}
