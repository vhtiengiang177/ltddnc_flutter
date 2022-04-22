import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: 20,
                ),
                Column(children: [
                  Padding(
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
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              imageFailed,
                              fit: BoxFit.fill,
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
                                    'Burger tom',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        /* '${formatCurrency.format(e.price)}'*/ '20 000 VND',
                                        style: TextStyle(
                                            color: ColorCustom.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Quantity(
                                            quantity: 1,
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
                  Padding(
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
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              imageFailed,
                              fit: BoxFit.fill,
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
                                    'Burger tom',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        /* '${formatCurrency.format(e.price)}'*/ '20 000 VND',
                                        style: TextStyle(
                                            color: ColorCustom.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: Quantity(
                                            quantity: 1,
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
                  )
                ])
              ],
            )),
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
                          "40 000 VND",
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
}
