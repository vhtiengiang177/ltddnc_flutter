import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/providers/category_provider.dart';
import 'package:ltddnc_flutter/screens/product_screen.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:provider/provider.dart';

class ListCategories extends StatefulWidget {
  const ListCategories({Key? key}) : super(key: key);

  @override
  State<ListCategories> createState() => _ListCategoriesState();
}

class _ListCategoriesState extends State<ListCategories> {
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    print(categoryProvider.listCategory.length);
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        physics: ScrollPhysics(),
        children: <Widget>[
          ...categoryProvider.listCategory.map((e) => InkWell(
                splashColor: ColorCustom.primaryColor,
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductScreen(category: e)))
                },
                child: Card(
                  color: ColorCustom.inputColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        e.image != null
                            ? Image.network(
                                '${e.image}',
                                width: 50,
                                height: 50,
                              )
                            : Image.asset(
                                'assets/images/categories.png',
                                width: 50,
                                height: 50,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            '${e.name}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        )
                      ]),
                ),
              ))
        ]);
  }
}
