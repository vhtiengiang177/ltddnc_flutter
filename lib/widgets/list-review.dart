import 'package:flutter/material.dart';
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
            children: reviewProvider.listReview.reversed
                .map(
                  (e) => InkWell(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 3.0),
                        child: Card(
                          color: Colors.white,
                          shadowColor: Colors.blueGrey,
                          elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 45,
                                      height: 45,  
                                      margin: EdgeInsets.only(right: 16.0),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.white, width: 2),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: e.image?.isNotEmpty == true
                                          ? CircleAvatar(
                                              backgroundImage:
                                                  NetworkImage(e.image ?? ''),
                                            )
                                          : CircleAvatar(
                                              backgroundImage: AssetImage(
                                                  'assets/images/profile-default.jpg'),
                                            ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        e.name ?? "",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: double.parse(e.rating.toString()),
                                      direction: Axis.horizontal,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 25,
                                    ),
                                    SizedBox(width: 16.0),
                                    Text(
                                      '${e.date}',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.0),
                                GestureDetector(
                                  child: Text(
                                    e.comment ?? "",
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
