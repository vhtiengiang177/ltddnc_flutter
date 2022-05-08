import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/providers/favorite_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';
import 'package:ltddnc_flutter/screens/product_detail_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/quantity.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ListProductFavorite extends StatefulWidget {
  const ListProductFavorite({Key? key}) : super(key: key);

  @override
  State<ListProductFavorite> createState() => _ListProductFavoriteState();
}

class _ListProductFavoriteState extends State<ListProductFavorite> {
  final formatCurrency = new NumberFormat.currency(locale: 'vi');

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return favoriteProvider.listProduct.isNotEmpty == true
        ? Column(
            children: favoriteProvider.listProduct
                .map(
                  (e) => InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen(
                                  product: e,
                                ))),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: ColorCustom.inputColor,
                      ),
                      clipBehavior: Clip.hardEdge,
                      margin: EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.network(
                              e.image ?? imageFailed,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    e.name ?? '',
                                    style: TextStyle(fontSize: 22),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${formatCurrency.format(e.unitPrice)}',
                                        style: TextStyle(
                                            color: ColorCustom.primaryColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Align(
                                          alignment: Alignment.centerRight,
                                          child: IconButton(
                                            icon: Image.asset(
                                              'assets/images/button/heart.png',
                                              width: 20,
                                              color: Colors.red,
                                            ),
                                            onPressed: () => {
                                              /* handle favorite */
                                              favoriteProvider.removeFavorite(userProvider.user?.idAccount,e)
                                            },
                                          )),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        : Text(
            "Không có sản phẩm",
            style: TextStyle(fontSize: 18),
          );
  }
}
