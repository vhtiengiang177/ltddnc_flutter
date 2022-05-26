import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../providers/review_provider.dart';

class ListReview extends StatefulWidget {
  const ListReview({Key? key}) : super(key: key);

  @override
  State<ListReview> createState() => _ListReviewState();
}

class _ListReviewState extends State<ListReview> {
  @override
  Widget build(BuildContext context) {
    final reviewProvider = Provider.of<ReviewProvider>(context);

    return reviewProvider.listReview.isNotEmpty == true
        ? Column(
            children: reviewProvider.listReview
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
                          margin: EdgeInsets.all(0),
                          color: Color.fromARGB(255, 250, 250, 241),
                          shadowColor: Colors.blueGrey,
                          elevation: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 45.0,
                                    width: 45.0,
                                    margin: EdgeInsets.only(right: 16.0),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/icon.png"),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.circular(44.0),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      e.name ?? "",
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
                                children: [
                                  RatingBar(
                                      initialRating: 5,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 25,
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
                                        // setState(() {
                                        //   _ratingValue = value;
                                        // });
                                      }),
                                  SizedBox(width: kFixPadding),
                                  Text(
                                    e.date ?? "20-01-2022",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              GestureDetector(
                                //onTap: onTap,
                                child:
                                    // ? Text(
                                    //     "So Good",
                                    //     style: TextStyle(
                                    //       fontSize: 18.0,
                                    //       color: kLightColor,
                                    //     ),
                                    //   )
                                    Text(
                                  e.comment ?? "",
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: kLightColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                )
                .toList(),
          )
        : Text(
            "Không có đánh giá",
            style: TextStyle(fontSize: 18),
          );
  }
}
