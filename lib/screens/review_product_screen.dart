import 'package:flutter/material.dart';
import '../models/order_detail.dart';

import '../widgets/list_review_product.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen({Key? key, required this.lOrderDetail})
      : super(key: key);
  final List<OrderDetail> lOrderDetail;

  @override
  _ReviewProductScreenState createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
            title: Text(
          'Đánh giá đơn hàng #${widget.lOrderDetail[0].idOrder}',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListReviewProduct(lOrderDetail: widget.lOrderDetail),
      ),
    );
  }

  Future<bool> _requestPop() {
    Navigator.of(context).pop(false);
    return new Future.value(false);
  }
}
