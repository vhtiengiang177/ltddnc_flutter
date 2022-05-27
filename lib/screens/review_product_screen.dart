import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/order.dart';
import '../models/order_detail.dart';
import '../models/product.dart';
import '../providers/order_provider.dart';
import '../providers/review_provider.dart';
import '../shared/constants.dart';
import '../widgets/list-review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../widgets/list_review_product.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({Key? key, required this.lOrderDetail})
      : super(key: key);
  // final Product product;
  final List<OrderDetail> lOrderDetail;
  // final OrderDetail orderDetail;

  @override
  _ReviewProductScreenState createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Stack(children: [
                SingleChildScrollView(
                  child: Column(children: [
                    Container(
                      height: 60,
                      color: Colors.amber,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(children: [
                            IconButton(
                                onPressed: () => Navigator.of(context).pop(''),
                                icon: Icon(Icons.arrow_back)),
                            Text(
                              'Đánh giá đơn hàng #${widget.lOrderDetail[0].idOrder}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )
                          ]),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          ListReviewProduct(lOrderDetail: widget.lOrderDetail),
                    ),
                  ]),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 720),
                //   child: Container(
                //     alignment: Alignment.center,
                //     height: 60,
                //     decoration: BoxDecoration(
                //         color: ColorCustom.inputColor,
                //         borderRadius: BorderRadius.circular(5)),
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //       child: Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text.rich(
                //             TextSpan(
                //                 text: "Trạng thái: ",
                //                 style: TextStyle(fontWeight: FontWeight.bold),
                //                 children: <InlineSpan>[
                //                   TextSpan(
                //                     text: "CHƯA ĐÁNH GIÁ",
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
                //                 "GỬI ĐÁNH GIÁ",
                //                 style: TextStyle(color: Colors.white),
                //               ),
                //               style: ButtonStyle(
                //                   backgroundColor:
                //                       MaterialStateProperty.all<Color>(
                //                           Colors.green)),
                //               onPressed: () {
                //                 // HANDLE REVIEW
                //                 // Navigator.push(
                //                 //   context,
                //                 //   MaterialPageRoute(
                //                 //     builder: (context) {
                //                 //       return ReviewProductScreen(
                //                 //           order: order);
                //                 //     },
                //                 //   ),
                //                 // );
                //               }),
                //         ],
                //       ),
                //     ),
                //   ),
                // )
              ]),
      ),
    );
  }
}
