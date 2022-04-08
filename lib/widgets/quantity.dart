import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

class Quantity extends StatefulWidget {
  const Quantity({Key? key}) : super(key: key);

  @override
  State<Quantity> createState() => _QuantityState();
}

class _QuantityState extends State<Quantity> {
  final quantity = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 25,
      child: Row(children: [
        Container(
            child: Icon(
              Icons.remove,
              size: 18,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: ColorCustom.primaryColor, width: 2))),
        Container(
            width: 25,
            height: 25,
            alignment: Alignment.center,
            child: Text(
              '${quantity}',
              style: TextStyle(fontSize: 16),
            )),
        Container(
            child: Icon(
              Icons.add,
              size: 18,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: ColorCustom.primaryColor,
                border: Border.all(color: ColorCustom.primaryColor, width: 2)))
      ]),
    );
  }
}
