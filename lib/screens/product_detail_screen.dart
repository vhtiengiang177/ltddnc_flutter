import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: ListView(
              children: [
                Container(
                  height: 250,
                  child: widget.product.image != null ? Image.network('${widget.product.image}',
                    fit: BoxFit.fitWidth,
                  ) : Image.asset('assets/no-image-available.jpg', fit: BoxFit.fitWidth,),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 8, left: 15.0, right: 15.0),
                  child: Text(
                    '${widget.product.name}',
                    style: TextStyle(
                        color: ColorCustom.primaryColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '${formatCurrency.format(widget.product.price)}',
                    style: TextStyle(
                        color: ColorCustom.secondaryColor,
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
                    style: TextStyle(fontSize: 16),
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
                      Quantity(),
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
}
