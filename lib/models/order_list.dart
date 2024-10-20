import 'package:dev_store/models/cart.dart';
import 'package:dev_store/models/order.dart';
import 'package:flutter/material.dart';

class OrderList with ChangeNotifier {
  final List<Order> _items = [];

  List<Order> get listOrder {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  void addOrder(Cart cart) {
    _items.insert(
      0,
      Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
