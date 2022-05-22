import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/favorite_provider.dart';
import 'package:ltddnc_flutter/widgets/list_product_favorite.dart';
import 'package:provider/provider.dart';
import 'package:ltddnc_flutter/providers/user_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      final userProvider = Provider.of<UserProvider>(context);
      Provider.of<FavoriteProvider>(context)
          .getProducts(userProvider.user?.idAccount)
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(children: [
                          Text(
                            'Sản phẩm yêu thích',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListProductFavorite(),
                  )
                ]),
              ),
      ),
    );
  }
}
