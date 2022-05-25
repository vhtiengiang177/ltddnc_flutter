import 'package:flutter/material.dart';
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
      setState(() {
        _isLoading = true;
      });
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);
      orderProvider.getOrderByState(1).then((_) {
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
                this.onTapHandler(index, orderProvider).whenComplete(() {
                  Future.delayed(Duration(seconds: 2))
                      .then((value) => setState(() {
                            _isLoading = false;
                          }));
                });
              }),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // Dang xu ly
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: ListOrder(
                      listOrder: orderProvider.listOrder,
                    ),
                  ),
                  // Dang giao
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: ListOrder(
                      listOrder: orderProvider.listOrder,
                    ),
                  ),
                  // Da giao
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: ListOrder(
                      listOrder: orderProvider.listOrder,
                    ),
                  ),
                  // Da huy
                  SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: 8.0,
                    ),
                    child: ListOrder(
                      listOrder: orderProvider.listOrder,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future<void> onTapHandler(int index, OrderProvider orderProvider) async {
    print("onTapHandler Order History");
    await orderProvider.getOrderByState(index + 1);
  }
}
