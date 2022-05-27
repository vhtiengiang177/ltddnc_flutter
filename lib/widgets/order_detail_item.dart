import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/providers/order_provider.dart';
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
  late OrderProvider orderProvider;
  Order? orderSelected;
  bool _isLoading = false;
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  @override
  void initState() {
    // setState(() {
    //   _isLoading = true;
    // });

    // orderProvider = Provider.of<OrderProvider>(context);

    // orderProvider.GetOrderDetailByIdOrder(widget.orderSelected.id!).then((_) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });

    // orderSelected = orderProvider.listOrder.firstWhere(
    //   (element) => element.id == widget.orderSelected.id,
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _setup(),
        builder: (context, snapshot) {
          return snapshot.connectionState != ConnectionState.done
              ? CircularProgressIndicator()
              : Builder(builder: (context) {
                  orderProvider = Provider.of<OrderProvider>(context);
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
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 10, 10, 3),
                                            child: Card(
                                              color: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 4, 0, 12),
                                                        child: Row(
                                                          children: [
                                                            Image.asset(
                                                              "assets/images/button/location.png",
                                                              width: 20,
                                                              color: ColorCustom
                                                                  .primaryColor,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text(
                                                              "Địa chỉ nhận hàng",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        "${orderSelected?.name}",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        "${orderSelected?.phone}",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                      ),
                                                      Text(
                                                        "${orderSelected?.address}",
                                                        style: TextStyle(
                                                            fontSize: 14),
                                                        maxLines: 3,
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 3.0),
                                            child: Card(
                                              color: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          0, 4, 0, 12),
                                                      child: Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/button/list.png",
                                                            width: 20,
                                                            color: ColorCustom
                                                                .primaryColor,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Sản phẩm",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Column(
                                                      children:
                                                          orderProvider
                                                              .listOrderDetail
                                                              .map(
                                                                (e) =>
                                                                    Container(
                                                                  height: 110,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    border:
                                                                        Border(
                                                                      top: BorderSide(
                                                                          color:
                                                                              Color(0xFFA7A7A7)),
                                                                    ),
                                                                  ),
                                                                  clipBehavior:
                                                                      Clip.hardEdge,
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Center(
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              90,
                                                                          height:
                                                                              90,
                                                                          clipBehavior:
                                                                              Clip.hardEdge,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(4),
                                                                          ),
                                                                          child: e.imageProduct != null
                                                                              ? Image.network(
                                                                                  '${e.imageProduct}',
                                                                                  fit: BoxFit.cover,
                                                                                )
                                                                              : Image.asset(
                                                                                  imageFailed,
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(horizontal: 10),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.stretch,
                                                                            children: [
                                                                              Text(
                                                                                '${e.nameProduct}',
                                                                                style: TextStyle(
                                                                                  fontSize: 16,
                                                                                  overflow: TextOverflow.ellipsis,
                                                                                  color: Colors.black,
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 8,
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.bottomRight,
                                                                                child: Text(
                                                                                  'x${e.quantity ?? 1}',
                                                                                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                                                                                ),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 4,
                                                                              ),
                                                                              Align(
                                                                                alignment: Alignment.bottomRight,
                                                                                child: Text(
                                                                                  '${formatCurrency.format(e.unitPrice ?? 0)}',
                                                                                  style: TextStyle(
                                                                                    fontSize: 16,
                                                                                    color: Colors.grey[700],
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
                                                      color: Color.fromARGB(
                                                          255, 107, 107, 107),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "Thành tiền:",
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            '${formatCurrency.format(orderSelected?.totalProductPrice)}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16,
                                                              color: Palette
                                                                  .lightTheme
                                                                  .shade100,
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
                                                horizontal: 10.0,
                                                vertical: 3.0),
                                            child: Card(
                                              color: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                    vertical: 8),
                                                child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 4, 0, 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Mã đơn hàng",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                            Text(
                                                              "${orderSelected?.id}",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                0, 4, 0, 12),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Thời gian đặt hàng: ",
                                                            ),
                                                            Text(
                                                              "${orderSelected?.createDate}",
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      orderSelected?.cancelDate
                                                                  ?.isNotEmpty ==
                                                              true
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .fromLTRB(
                                                                      0,
                                                                      4,
                                                                      0,
                                                                      12),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Text(
                                                                    "Thời gian huỷ đơn: ",
                                                                  ),
                                                                  Text(
                                                                    "${orderSelected?.cancelDate}",
                                                                  ),
                                                                ],
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              height: 0,
                                                            ),
                                                    ]),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  actionButton(context, orderProvider)
                                ],
                              )
                            ],
                          ),
                  );
                });
        });
  }

  Widget actionButton(BuildContext context, OrderProvider orderProvider) {
    Widget widget = Container();
    var state = orderSelected?.state!;
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
              if (orderSelected?.state == 1)
                ElevatedButton(
                    child: Text(
                      "HUỶ ĐƠN HÀNG",
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red)),
                    onPressed: () {
                      showAlertDialog(
                              context,
                              "Bạn có chắc chắn huỷ đơn không?",
                              ["Đồng ý", "Huỷ"],
                              "Thông báo")
                          .then((value) => {
                                if (value)
                                  {
                                    orderProvider
                                        .updateStateOrder(orderSelected!.id!, 4)
                                        .then((value) => {
                                              setState(() {
                                                orderSelected?.state = 4;
                                              }),
                                              print(
                                                  '---------oreder state: ${orderSelected?.state}-------'),
                                              orderProvider.listOrder
                                                  .removeWhere((e) =>
                                                      e.id == orderSelected?.id)
                                            })
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
                  }),
            ],
          ),
        ),
      );
    } else if (state == 4) {
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
                        text: "ĐÃ HUỶ",
                        style: TextStyle(
                          color: ColorCustom.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ]),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  onSurface: Colors.white,
                  onPrimary: Colors.white,
                  primary: Colors.white,
                  shadowColor: Colors.white,
                ),
                onPressed: null,
                child: Text(
                  "",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return widget;
  }

  Future<void> _setup() async {
    final temp = Provider.of<OrderProvider>(context, listen: false);

    temp.GetOrderDetailByIdOrder(widget.orderSelected.id!);
    if (orderSelected == null) {
      orderSelected = temp.listOrder.firstWhere(
        (element) => element.id == widget.orderSelected.id,
      );
    }
  }
}
