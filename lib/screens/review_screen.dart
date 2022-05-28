import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/order_detail.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../providers/order_provider.dart';
import '../providers/review_provider.dart';
import '../shared/constants.dart';
import '../widgets/list-review.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<ReviewScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ReviewProvider>(context)
          .getReviews(widget.product.id)
          .then((_) {
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
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      'Đánh giá ${widget.product.name}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                ],
              ),
            ),
            Container(
              color: kAccentColor,
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: widget.product.avgRating.toString(),
                              style: TextStyle(fontSize: 30.0),
                            ),
                            TextSpan(
                              text: "/5",
                              style: TextStyle(
                                fontSize: 24.0,
                                color: kLightColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RatingBarIndicator(
                        rating:
                            double.parse(widget.product.avgRating.toString()),
                        direction: Axis.horizontal,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 25,
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "${reviewProvider.listReview.length} Đánh giá",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: kLightColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListReview(),
            )
          ]),
        ),
      ),
    );
  }
}
