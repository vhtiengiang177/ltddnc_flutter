import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/providers/order_provider.dart';
import 'package:ltddnc_flutter/screens/review_product_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/alert-dialog.dart';
import 'package:provider/provider.dart';

class OrderDetailItem extends StatefulWidget {
  const OrderDetailItem({Key? key, required this.orderSelected})
      : super(key: key);

  final Order orderSelected;
  @override
  State<OrderDetailItem> createState() => _OrderDetailItemState();
}

class _OrderDetailItemState extends State<OrderDetailItem> {
  bool _isInit = true;
  bool _isLoading = false;
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.GetOrderDetailByIdOrder(widget.orderSelected.id!).then((_) {
        setState(() {
          _isLoading = false;
        });
      });

      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Chi tiết đơn hàng"),
        backgroundColor: ColorCustom.buttonSecondaryColor,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 3),
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 12),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                "assets/images/button/location.png",
                                                width: 20,
                                                color: ColorCustom.primaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Địa chỉ nhận hàng",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              )
                                            ],
                                          ),
                                        ),
                                        Text(
                                          "${widget.orderSelected.name}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          "${widget.orderSelected.phone}",
                                          style: TextStyle(fontSize: 14),
                                        ),
                                        Text(
                                          "${widget.orderSelected.address}",
                                          style: TextStyle(fontSize: 14),
                                          maxLines: 3,
                                        ),
                                      ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 4, 0, 12),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/button/list.png",
                                              width: 20,
                                              color: ColorCustom.primaryColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Sản phẩm",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16),
                                            )
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: orderProvider.listOrderDetail
                                            .map(
                                              (e) => Container(
                                                height: 110,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        color:
                                                            Color(0xFFA7A7A7)),
                                                  ),
                                                ),
                                                clipBehavior: Clip.hardEdge,
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Center(
                                                      child: Container(
                                                        width: 90,
                                                        height: 90,
                                                        clipBehavior:
                                                            Clip.hardEdge,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                        ),
                                                        child: e.imageProduct !=
                                                                null
                                                            ? Image.network(
                                                                '${e.imageProduct}',
                                                                fit: BoxFit
                                                                    .cover,
                                                              )
                                                            : Image.asset(
                                                                imageFailed,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 10),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                          children: [
                                                            Text(
                                                              '${e.nameProduct}',
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 8,
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Text(
                                                                'x${e.quantity ?? 1}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                            .grey[
                                                                        600],
                                                                    fontSize:
                                                                        14),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 4,
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomRight,
                                                              child: Text(
                                                                '${formatCurrency.format(e.unitPrice ?? 0)}',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                          .grey[
                                                                      700],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                      Divider(
                                        color:
                                            Color.fromARGB(255, 107, 107, 107),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Thành tiền:",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              '${formatCurrency.format(widget.orderSelected.totalProductPrice)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color:
                                                    Palette.lightTheme.shade100,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              child: Card(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 8),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Mã đơn hàng",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                              Text(
                                                "${widget.orderSelected.id}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 4, 0, 12),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Thời gian đặt hàng: ",
                                              ),
                                              Text(
                                                "${widget.orderSelected.createDate}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    actionButton(context, widget.orderSelected.state,
                        widget.orderSelected, orderProvider.listOrderDetail)
                  ],
                )
              ],
            ),
    );
  }
}

Widget actionButton(BuildContext context, int? state, Order order,
    List<OrderDetail> lOrderDetail) {
  Widget widget = Container();
  if (state == 1) {
    widget = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                  text: "Trạng thái: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "ĐANG XỬ LÝ",
                      style: TextStyle(
                        color: ColorCustom.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ),
            ElevatedButton(
                child: Text(
                  "HUỶ ĐƠN HÀNG",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.red)),
                onPressed: () {
                  showAlertDialog(context, "Bạn có chắc chắn huỷ đơn không?",
                          ["Đồng ý", "Huỷ"], "Thông báo")
                      .then((value) => {
                            if (value)
                              {
                                // handle cancel
                              }
                          });
                }),
          ],
        ),
      ),
    );
  } else if (state == 2) {
    widget = Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                  text: "Trạng thái: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "ĐANG GIAO HÀNG",
                      style: TextStyle(
                        color: ColorCustom.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  } else if (state == 3) {
    widget = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text.rich(
              TextSpan(
                  text: "Trạng thái: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "ĐÃ GIAO",
                      style: TextStyle(
                        color: ColorCustom.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ),
            ElevatedButton(
                child: Text(
                  "ĐÁNH GIÁ SẢN PHẨM",
                  style: TextStyle(color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
                onPressed: () {
                  // HANDLE REVIEW
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return ReviewProductScreen(lOrderDetail: lOrderDetail);
                      },
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
  // else if (state == 3 && order.reviewState == 1) {
  //   widget = Container(
  //     alignment: Alignment.center,
  //     decoration: BoxDecoration(
  //       color: Colors.grey[50],
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.5),
  //           spreadRadius: 8,
  //           blurRadius: 7,
  //           offset: Offset(0, 3), // changes position of shadow
  //         ),
  //       ],
  //     ),
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 12.0),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Text.rich(
  //             TextSpan(
  //                 text: "Trạng thái: ",
  //                 style: TextStyle(fontWeight: FontWeight.bold),
  //                 children: <InlineSpan>[
  //                   TextSpan(
  //                     text: "ĐÃ GIAO",
  //                     style: TextStyle(
  //                       color: ColorCustom.primaryColor,
  //                       fontWeight: FontWeight.bold,
  //                       fontSize: 15,
  //                     ),
  //                   ),
  //                 ]),
  //           ),
  //           ElevatedButton(
  //               child: Text(
  //                 "ĐÁNH GIÁ SẢN PHẨM",
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //               style: ButtonStyle(
  //                   backgroundColor: MaterialStateProperty.all<Color>(
  //                       Color.fromARGB(255, 93, 94, 93))),
  //               onPressed: () {
  //                 // HANDLE REVIEW
  //               }),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  return widget;
}
