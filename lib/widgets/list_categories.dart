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
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: <Widget>[
          ...categoryProvider.listCategory.map((e) => InkWell(
                splashColor: ColorCustom.primaryColor,
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductScreen(category: e)))
                },
                child: Container(
                  height: 100,
                  width: 100,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    color: ColorCustom.inputColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: e.image != null
                              ? Image.network(
                                  '${e.image}',
                                  width: 40,
                                  height: 40,
                                )
                              : Image.asset(
                                  'assets/images/categories.png',
                                  width: 40,
                                  height: 40,
                                ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          '${e.name}',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}
