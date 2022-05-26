import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:ltddnc_flutter/providers/cart_provider.dart';
import 'package:ltddnc_flutter/providers/favorite_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ltddnc_flutter/providers/review_provider.dart';
import 'package:ltddnc_flutter/screens/review_screen.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');
  int quantity = 1;
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: ListView(
              children: [
                Container(
                  height: 250,
                  child: widget.product.image != null
                      ? Image.network(
                          '${widget.product.image}',
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          imageFailed,
                          fit: BoxFit.cover,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 8, left: 15.0, right: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${widget.product.name}',
                        style: TextStyle(
                            color: ColorCustom.textPrimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                          height: 50,
                          child: favoriteProvider.listProduct
                                      .where((e) => e.id == widget.product.id)
                                      .length >
                                  0
                              ? IconButton(
                                  icon: Image.asset(
                                    'assets/images/button/heart.png',
                                    width: 30,
                                    color: favoriteProvider.listProduct
                                                .where((e) =>
                                                    e.id == widget.product.id)
                                                .length >
                                            0
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  onPressed: () => {
                                    setState(
                                      () {
                                        // iconHeart = 'heart-regular';
                                        favoriteProvider.removeFavorite(
                                            userProvider.user?.idAccount,
                                            widget.product);
                                      },
                                    )
                                  },
                                )
                              : IconButton(
                                  icon: Image.asset(
                                    'assets/images/button/heart-regular.png',
                                    width: 30,
                                    color: favoriteProvider.listProduct
                                                .where((e) =>
                                                    e.id == widget.product.id)
                                                .length >
                                            0
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  onPressed: () => {
                                    setState(
                                      () {
                                        // iconHeart = 'heart';
                                        favoriteProvider.addFavorite(
                                            userProvider.user?.idAccount,
                                            widget.product);
                                      },
                                    )
                                    /* handle favorite */
                                  },
                                )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                    '${formatCurrency.format(widget.product.unitPrice)}',
                    style: TextStyle(
                        color: ColorCustom.textPrimaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: Text(
                    widget.product.description ?? '',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 6,
                    style: TextStyle(
                        fontSize: 16, color: ColorCustom.secondaryColor),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Đánh giá",
                        style: TextStyle(
                            color: ColorCustom.textPrimaryColor,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      //
                      TextButton(
                        onPressed: () async {
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewScreen(
                                        product: widget.product,
                                      )));

                          // setState(() {
                          //   if (result != null) _email.text = result.toString();
                          // });
                        },
                        child: Text(
                          'Xem tất cả',
                          style: TextStyle(
                              fontSize: 20,
                              color: ColorCustom.primaryColor,
                              decoration: TextDecoration.underline),
                        ),
                      ),
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
                          Row(children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: "4.5",
                                    style: TextStyle(fontSize: 30.0),
                                  ),
                                  TextSpan(
                                    text: "/5",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      color: kLightColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RatingBar(
                                initialRating: 4.5,
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
                          ]),
                          SizedBox(height: 16.0),
                          Text(
                            "5 Reviews",
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
                Card(
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
                              "Bảo",
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
                            "20-02-2022",
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
                          "So bad",
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
                )
              ],
            )),
            Padding(
              padding: const EdgeInsets.all(10.0),
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
                      Quantity(
                        onChangeQuantity: onChangeQuantity,
                        quantity: 1,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            final prefs = await SharedPreferences.getInstance();
                            final id = prefs.getString('userId');
                            if (id != null) {
                              Cart cart = new Cart(
                                  idUser: int.parse(id),
                                  idProduct: widget.product.id,
                                  quantity: quantity);
                              cartProvider.addItem(cart).then((value) => {
                                    Fluttertoast.showToast(msg: value),
                                    cartProvider.getCart(int.parse(id))
                                  });
                            }
                          },
                          child: Text("Thêm vào giỏ",
                              style: TextStyle(fontSize: 18)))
                    ],
                  ),
                ),
              ),
            )
          ]),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Color.fromARGB(190, 149, 149, 149)),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(''),
                icon: Icon(Icons.arrow_back),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  bool onChangeQuantity(bool isIncrease, int? index) {
    quantity += isIncrease ? 1 : -1;
    return true;
  }
}
