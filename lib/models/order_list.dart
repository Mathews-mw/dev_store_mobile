import 'package:dev_store/models/cart.dart';
import 'package:dev_store/models/cart_item.dart';
import 'package:dev_store/models/order.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderList with ChangeNotifier {
  final _dbBaseUrl = 'https://shop-coder-8a8b3-default-rtdb.firebaseio.com';
  final List<Order> _items = [];

  List<Order> get listOrder {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    _items.clear();

    final response = await http.get(Uri.parse('$_dbBaseUrl/orders.json'));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((orderId, orderData) {
      _items.add(Order(
        id: orderId,
        date: DateTime.parse(orderData['date']),
        total: orderData['total'],
        products: (orderData['products'] as List<dynamic>).map((item) {
          return CartItem(
            id: item['id'],
            productId: item['productId'],
            title: item['title'],
            quantity: item['quantity'],
            price: item['price'],
          );
        }).toList(),
      ));
    });

    notifyListeners();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('$_dbBaseUrl/orders.json'),
      body: jsonEncode({
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "total": cart.totalAmount,
        "date": date.toIso8601String(),
        "products": cart.items.values
            .map(
              (cartItem) => {
                'id': cartItem.id,
                'productId': cartItem.productId,
                'title': cartItem.title,
                'quantity': cartItem.quantity,
                'price': cartItem.price,
              },
            )
            .toList(),
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.insert(
      0,
      Order(
        id: id,
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: date,
      ),
    );

    notifyListeners();
  }
}
