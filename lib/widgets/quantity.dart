import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

class Quantity extends StatefulWidget {
  Quantity({Key? key, required this.quantity, required this.onChangeQuantity})
      : super(key: key);

  final Function onChangeQuantity;
  final int quantity;
  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  int quantity = 0;

  @override
  void initState() {
    quantity = widget.quantity;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 30,
      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        InkWell(
          onTap: decreaseQuantity,
          child: Container(
              child: Icon(
                Icons.remove,
                size: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border:
                      Border.all(color: ColorCustom.primaryColor, width: 2))),
        ),
        Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            child: Text(
              '${quantity}',
              style: TextStyle(fontSize: 16),
            )),
        InkWell(
          onTap: increaseQuantity,
          child: Container(
              child: Icon(
                Icons.add,
                size: 20,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: ColorCustom.primaryColor,
                  border:
                      Border.all(color: ColorCustom.primaryColor, width: 2))),
        )
      ]),
    );
  }

  void decreaseQuantity() {
    print("decrease quantity");
    if (quantity >= 1) {
      widget.onChangeQuantity(false);

      setState(() {
        quantity -= 1;
      });
    }
  }

  void increaseQuantity() {
    print("increase quantity");
    widget.onChangeQuantity(true);
    setState(() {
      quantity += 1;
    });
  }
}
