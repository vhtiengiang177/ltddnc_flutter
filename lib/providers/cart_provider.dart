import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:ltddnc_flutter/models/cart.dart';
import 'package:ltddnc_flutter/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:ltddnc_flutter/shared/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/alert-dialog.dart';

class CartProvider with ChangeNotifier {
  // Cart? cart;
  List<Cart> listCart = [];

  // CartProvider({this.cart});
  CartProvider();
  static var client = http.Client();
  final routeAPICart = "/carts";

  int get getTotalQuantity {
    int total = 0;

    this.listCart.forEach((element) {
      total = total + (element.quantity ?? 0);
    });

    return total;
  }

  void clearCarts() {
    this.listCart = [];

    notifyListeners();
  }

  Future<void> getCart(int? idUser) async {
    print("getCart: ");
    listCart = [];

    var response = await client.get(
        Uri.parse(
            apiHost + routeAPICart + "/GetAllItemsInCart/" + idUser.toString()),
        headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      print("response body " + response.body);
      var cartResponse = json.decode(response.body);
      for (var c in cartResponse) {
        print(c['product']);
        String createdDate = c['product']["createdDate"] != null
            ? DateFormat('dd-MM-yyyy HH:mm')
                .format(DateTime.parse(c['product']["createdDate"]))
            : '';
        Product product = Product(
          id: c['product']['id'],
          name: c['product']['name'],
          description: c['product']['description'],
          unitPrice: c['product']['unitPrice'],
          image: c['product']['image'],
          stock: c['product']['stock'],
          state: c['product']['state'],
          idCategory: c['product']['stock'],
          avgRating: c['product']["avgRating"],
          createdDate: createdDate,
        );
        Cart cart = Cart(
            idUser: c['idUser'],
            idProduct: c['idProduct'],
            quantity: c['quantity'],
            product: product);
        listCart.add(cart);
      }
      print(listCart.length);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("cart", response.body);
      notifyListeners();
    } else if (response.statusCode == 400) {
      print("getCart failed");
    }
  }

  Future<void> getCartLocal() async {
    print("getCartLocal: ");
    listCart = [];

    final prefs = await SharedPreferences.getInstance();
    String response = prefs.getString("cart").toString();

    var cartResponse = json.decode(response);
    for (var c in cartResponse) {
      print(c['product']);
      String createdDate = c['product']["createdDate"] != null
          ? DateFormat('dd-MM-yyyy HH:mm')
              .format(DateTime.parse(c['product']["createdDate"]))
          : '';
      Product product = Product(
        id: c['product']['id'],
        name: c['product']['name'],
        description: c['product']['description'],
        unitPrice: c['product']['unitPrice'],
        image: c['product']['image'],
        stock: c['product']['stock'],
        state: c['product']['state'],
        idCategory: c['product']['stock'],
        avgRating: c['product']["avgRating"],
        createdDate: createdDate,
      );
      Cart cart = Cart(
          idUser: c['idUser'],
          idProduct: c['idProduct'],
          quantity: c['quantity'],
          product: product);
      listCart.add(cart);
    }

    notifyListeners();
  }

  Future<String> addItem(Cart cart) async {
    print("addItem: ");

    var response = await client.post(
        Uri.parse(apiHost + routeAPICart + "/AddItem"),
        body: cartToJson(cart),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return (response.body);
    } else if (response.statusCode == 400) {
      print("Failed");
      return (response.body);
    }

    return "Lỗi hệ thống";
  }

  Future<Response> deleteItems(List<Cart> listCartDeleted) async {
    print("deleteItems: ");
    print(listCartDeleted);

    var response = await client.post(
        Uri.parse(apiHost + routeAPICart + "/DeleteItemsInCart"),
        body: json.encode(listCartDeleted),
        headers: {"Content-Type": "application/json"});
    print(response.statusCode);

    notifyListeners();
    return (response);
  }

  Future<bool> onQuantityChanged(
    BuildContext context,
    int index, {
    isInscrease = true,
  }) async {
    if (index < 0) {
      return false;
    }

    final quantity = this.listCart.elementAt(index).quantity;

    if (isInscrease == false && quantity == 1) {
      await showAlertDialog(context, "Bạn có chắc chắn xoá sản phẩm không?",
              ["Đồng ý", "Huỷ"], "Thông báo")
          .then(
        (value) => {
          if (value)
            {
              this
                  .deleteItems(
                      this.listCart.getRange(index, index + 1).toList())
                  .then((value) async {
                this.listCart.removeRange(index, index + 1);
                this.updateListCartLocal();
                if (value.statusCode == 200) {
                  Fluttertoast.showToast(msg: value.body);
                } else if (value.statusCode == 400) {
                  Fluttertoast.showToast(msg: value.body);
                }
              })
            }
        },
      );

      notifyListeners();
      return false;
    }

    this.listCart.elementAt(index).quantity =
        (quantity ?? 0) + (isInscrease ? 1 : -1);

    notifyListeners();

    await updateListCartLocal();

    return true;
  }

  updateListCartLocal() async {
    var newListCarts = json.encode(listCart);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("cart", newListCarts);
  }
}
