import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltddnc_flutter/mock/carousel.dart';
import 'package:ltddnc_flutter/providers/category_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/list_categories.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<CategoryProvider>(context).getAll().then((_) {
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
    return ListView(
      shrinkWrap: true,
      physics: ScrollPhysics(),
      children: <Widget>[
        Container(
          height: 50,
          child: Center(
              child: Text("Burger Bistro",
                  style: GoogleFonts.patuaOne(
                    color: ColorCustom.primaryColor,
                    fontSize: 32,
                  ))),
        ),
        // Padding(
        //   padding:
        //       EdgeInsets.only(top: 8.0, bottom: 8.0, left: 10.0, right: 10.0),
        //   child: TextField(
        //       cursorRadius: Radius.circular(5.0),
        //       decoration: InputDecoration(
        //         prefixIcon: Icon(Icons.search),
        //         hintText: 'Tìm  kiếm...',
        //         fillColor: ColorCustom.inputColor,
        //         filled: true,
        //         enabledBorder: InputBorder.none,
        //       ),
        //       style: TextStyle(fontSize: 18),
        //       textInputAction: TextInputAction.search),
        // ),
        CarouselSlider(
          options: CarouselOptions(
            height: 180.0,
            enlargeCenterPage: true,
            autoPlay: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.8,
          ),
          items: imgCarouselList
              .map((item) => Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage(item),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ))
              .toList(),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 15),
          child: Text(
            'DANH MỤC',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: ColorCustom.primaryColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: _isLoading
              ? Container(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : ListCategories(),
        ),
      ],
    );
  }
}
