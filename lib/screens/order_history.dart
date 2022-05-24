import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ltddnc_flutter/models/order.dart';
import 'package:ltddnc_flutter/providers/order_provider.dart';
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:ltddnc_flutter/widgets/list_order.dart';
import 'package:provider/provider.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({Key? key}) : super(key: key);

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  bool _isInit = true;
  bool _isLoading = false;
  List<Order> listOrder = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      // EasyLoading.show();
      setState(() {
        _isLoading = true;
      });
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.getOrderByState(1).then((_) {
        // EasyLoading.dismiss();
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
    final orderProvider = Provider.of<OrderProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Đơn hàng của bạn"),
          backgroundColor: ColorCustom.buttonSecondaryColor,
          centerTitle: true,
          bottom: TabBar(
              tabs: [
                Tab(
                  text: "Đang xử lý",
                ),
                Tab(
                  text: "Đang giao",
                ),
                Tab(
                  text: "Đã giao",
                ),
                Tab(
                  text: "Đã huỷ",
                )
              ],
              indicatorColor: ColorCustom.primaryColor,
              onTap: (index) {
                setState(() {
                  _isLoading = true;
                });
                this.onTapHandler(index).whenComplete(() {
                  Future.delayed(Duration(seconds: 2))
                      .then((value) => setState(() {
                            _isLoading = false;
                          }));
                });
              }),
        ),
        body: TabBarView(children: [
          // Dang xu ly
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: ListOrder(
                    listOrder: orderProvider.listOrder,
                  ),
                ),
          // Dang giao
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: ListOrder(
                    listOrder: orderProvider.listOrder,
                  ),
                ),
          // Da giao
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: ListOrder(
                    listOrder: orderProvider.listOrder,
                  ),
                ),
          // Da huy
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  padding: EdgeInsets.only(
                    top: 8.0,
                  ),
                  child: ListOrder(
                    listOrder: orderProvider.listOrder,
                  ),
                ),
        ]),
      ),
    );
  }

  Future<void> onTapHandler(int index) async {
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    print("onTapHandler Order History");
    await orderProvider.getOrderByState(index + 1);
  }
}
