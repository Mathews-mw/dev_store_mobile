import 'dart:math';

import 'package:dev_store/models/cart_item.dart';
import 'package:dev_store/models/product.dart';
import 'package:flutter/material.dart';

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double amount = 0.0;

    items.forEach((key, cartItem) {
      amount += cartItem.price * cartItem.quantity;
    });

    return amount;
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (cartProduct) => CartItem(
          id: cartProduct.id,
          productId: cartProduct.productId,
          title: cartProduct.title,
          quantity: cartProduct.quantity + 1,
          price: cartProduct.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          productId: product.id,
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }

    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }

    if (_items[productId]?.quantity == 1) {
      _items.remove(productId);
    } else {
      _items.update(
        productId,
        (cartProduct) => CartItem(
          id: cartProduct.id,
          productId: cartProduct.productId,
          title: cartProduct.title,
          quantity: cartProduct.quantity - 1,
          price: cartProduct.price,
        ),
      );
    }

    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
