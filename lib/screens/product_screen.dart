import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/category.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/screens/cart_screen.dart';
import 'package:ltddnc_flutter/widgets/list_product.dart';
import 'package:provider/provider.dart';
import 'package:ltddnc_flutter/providers/favorite_provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key, required this.category}) : super(key: key);
  final Category category;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductProvider>(context)
          .getProducts(widget.category.id)
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
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                            '${widget.category.name}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ]),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: IconButton(
                              icon: Image.asset(
                                'assets/images/button/shopping-cart.png',
                                width: 24,
                              ),
                              onPressed: () => {
                                /* handle cart */
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartScreen(
                                              isBack: true,
                                            ))),
                              },
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListProduct(),
                  )
                ]),
              ),
      ),
    );
  }
}
