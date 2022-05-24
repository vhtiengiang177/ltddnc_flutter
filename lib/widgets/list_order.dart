import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/shared/constants.dart';

class ListOrder extends StatefulWidget {
  const ListOrder({Key? key, required this.listOrder}) : super(key: key);

  final List<Order> listOrder;
  @override
  State<ListOrder> createState() => _ListOrderState();
}

class _ListOrderState extends State<ListOrder> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  @override
  Widget build(BuildContext context) {
    return widget.listOrder.isNotEmpty == true
        ? Column(
            children: widget.listOrder
                .map(
                  (e) => InkWell(
                    // onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => ProductDetailScreen(
                    //               product: e,
                    //             ))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 3.0),
                      child: Card(
                        child: Container(
                          height: 160,
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                      top: 8,
                                      left: 10,
                                    ),
                                    width: 90,
                                    height: 90,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child:
                                        e.firstOrderDetail!.imageProduct != null
                                            ? Image.network(
                                                '${e.firstOrderDetail!.imageProduct}',
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                imageFailed,
                                                fit: BoxFit.cover,
                                              ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 90,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              '${e.firstOrderDetail!.nameProduct}',
                                              style: TextStyle(
                                                fontSize: 15,
                                                overflow: TextOverflow.ellipsis,
                                                color: Colors.black,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                'x${e.firstOrderDetail!.quantity ?? 1}',
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 14),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: Text(
                                                '${formatCurrency.format(e.firstOrderDetail!.unitPrice ?? 0)}',
                                                style: TextStyle(
                                                  color: Colors.grey[700],
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              const Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 5.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('${e.totalQuantity} sản phẩm'),
                                    Text.rich(TextSpan(
                                        text: "Thành tiền: ",
                                        children: <InlineSpan>[
                                          TextSpan(
                                            text:
                                                "${formatCurrency.format(e.totalProductPrice)}",
                                            style: TextStyle(
                                              color: ColorCustom.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ]))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon/icon-food.png',
                  width: 90,
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Chưa có đơn hàng",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
  }
}
