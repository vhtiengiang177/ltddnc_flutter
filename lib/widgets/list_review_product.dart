import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/models/review.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/order_provider.dart';
import '../providers/review_provider.dart';
import 'package:intl/intl.dart';

import '../providers/user_provider.dart';

class ListReviewProduct extends StatefulWidget {
  const ListReviewProduct({Key? key, required this.lOrderDetail})
      : super(key: key);
  final List<OrderDetail> lOrderDetail;
  @override
  State<ListReviewProduct> createState() => _ListReviewProductState();
}

class _ListReviewProductState extends State<ListReviewProduct> {
  bool _isInit = true;
  bool _isLoading = false;
  double _totalPrice = 0;
  bool checkedAllItems = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final reviewProvider =
          Provider.of<ReviewProvider>(context, listen: false);
      reviewProvider.orderDetailMapToReview(widget.lOrderDetail).then((_) {
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
    final reviewProvider = Provider.of<ReviewProvider>(context);
    double? _ratingValue;
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    final _comment = TextEditingController();

    return Stack(
      children: [
        _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: reviewProvider.listReview
                    .map(
                      (e) => InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 1.0, vertical: 1.0),
                          child: Card(
                            margin: EdgeInsets.all(10),
                            color: Color.fromARGB(255, 250, 250, 241),
                            shadowColor: Colors.blueGrey,
                            elevation: 10,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 70.0,
                                      width: 70.0,
                                      padding: EdgeInsets.all(8.0),
                                      margin: EdgeInsets.only(right: 16.0),
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
                                    Expanded(
                                      child: Text(
                                        "${e.nameProduct}",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: null,
                                      icon: Icon(Icons.more_vert),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    RatingBar(
                                        initialRating: e.rating!,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        minRating: 0,
                                        itemSize: 30,
                                        ratingWidget: RatingWidget(
                                            full: const Icon(Icons.star,
                                                color: Colors.orange),
                                            half: const Icon(
                                              Icons.star_half,
                                              color: Colors.orange,
                                            ),
                                            empty: const Icon(
                                              Icons.star_outline,
                                              color: Colors.orange,
                                            )),
                                        onRatingUpdate: (value) {
                                          e.rating = value;
                                        }),
                                    SizedBox(width: kFixPadding),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                      maxLines: 4,
                                      maxLength: 50,
                                      onChanged: (value) => e.comment = value,
                                      decoration: InputDecoration(
                                          hintText: 'Nhập đánh giá ...',
                                          fillColor: ColorCustom.inputColor,
                                          enabledBorder:
                                              const OutlineInputBorder(
                                            // width: 0.0 produces a thin "hairline" border
                                            borderSide: const BorderSide(
                                                color: Colors.grey, width: 0.0),
                                          ),
                                          border: const OutlineInputBorder(),
                                          contentPadding: EdgeInsets.only(
                                              left: 10, right: 10, top: 10)),
                                      style: TextStyle(
                                        fontSize: 18,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
        Container(
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
              padding: const EdgeInsets.only(top: 0),
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
                      Text.rich(
                        TextSpan(
                            text: "Trạng thái: ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            children: <InlineSpan>[
                              TextSpan(
                                text: "CHƯA ĐÁNH GIÁ",
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
                            "GỬI ĐÁNH GIÁ",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.green)),
                          onPressed: () {
                            reviewProvider.listReview.forEach((element) {
                              print(element.comment);
                              reviewProvider.addReview(element);
                            });
                            Navigator.of(context).pop('');
                            Fluttertoast.showToast(msg: 'Đánh giá thành công');
                          }),
                    ],
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
