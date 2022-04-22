import 'package:flutter/material.dart';
import 'package:ltddnc_flutter/models/category.dart';
import 'package:ltddnc_flutter/providers/product_provider.dart';
import 'package:ltddnc_flutter/widgets/list_product.dart';
import 'package:provider/provider.dart';

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
          .getAll(widget.category.id)
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
            : Column(children: [
                Container(
                  height: 60,
                  color: Colors.amber,
                  child: Row(children: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(''),
                        icon: Icon(Icons.arrow_back)),
                    Text(
                      '${widget.category.name}',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListProduct(),
                )
              ]),
      ),
    );
  }
}
