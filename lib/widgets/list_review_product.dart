import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/review_provider.dart';

class ListReviewProduct extends StatefulWidget {
  const ListReviewProduct({Key? key, required this.lOrderDetail})
      : super(key: key);
  final List<OrderDetail> lOrderDetail;
  @override
  State<ListReviewProduct> createState() => _ListReviewProductState();
}

class _ListReviewProductState extends State<ListReviewProduct> {
  bool _isInit = true;
  bool checkedAllItems = false;
  // bool _isLoading = false;

  @override
  Future<void> didChangeDependencies() async {
    if (_isInit) {
      final reviewProvider =
          Provider.of<ReviewProvider>(context, listen: false);
      reviewProvider.orderDetailMapToReview(widget.lOrderDetail);
      _isInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: reviewProvider.listReview
                      .map(
                        (e) => InkWell(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1.0, vertical: 1.0),
                            child: Card(
                              margin: EdgeInsets.all(10),
                              color: Colors.white,
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
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RatingBar(
                                          initialRating: e.rating ?? 5,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          minRating: 0,
                                          itemSize: 30,
                                          ratingWidget: RatingWidget(
                                              full: const Icon(Icons.star,
                                                  color: Color.fromARGB(
                                                      255, 255, 221, 0)),
                                              half: const Icon(Icons.star_half,
                                                  color: Color.fromARGB(
                                                      255, 255, 221, 0)),
                                              empty: const Icon(
                                                  Icons.star_outline,
                                                  color: Color.fromARGB(
                                                      255, 255, 221, 0))),
                                          onRatingUpdate: (value) {
                                            e.rating = value;
                                          }),
                                      SizedBox(width: 16.0),
                                    ],
                                  ),
                                  SizedBox(height: 8.0),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: TextField(
                                        maxLines: 4,
                                        maxLength: 150,
                                        onChanged: (value) => e.comment = value,
                                        decoration: InputDecoration(
                                            hintText: 'Nh???p ????nh gi??...',
                                            fillColor: ColorCustom.inputColor,
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Colors.grey,
                                                  width: 0.0),
                                            ),
                                            border: const OutlineInputBorder(),
                                            contentPadding: EdgeInsets.only(
                                                left: 10, right: 10, top: 10)),
                                        style: TextStyle(
                                          fontSize: 16,
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
              ),
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
                      offset: Offset(0, 3),
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              child: Text(
                                "G???I ????NH GI??",
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.green)),
                              onPressed: () {
                                reviewProvider
                                    .addReview(reviewProvider.listReview);
                                Navigator.of(context).pop(true);
                                Fluttertoast.showToast(
                                    msg: '????nh gi?? th??nh c??ng');
                              }),
                        ],
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ],
    );
  }
}
