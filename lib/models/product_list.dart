import 'dart:math';

import 'package:dev_store/data/dummy_data.dart';
import 'package:dev_store/models/product.dart';
import 'package:flutter/material.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get products {
    return [
      ..._items
    ]; // retornar uma cópia de _items ao invés de apontar para a referência original da lista
  }

  int get itemsCount {
    return _items.length;
  }

  List<Product> get favoriteProducts {
    return _items.where((product) => product.isFavorite).toList();
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        title: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String);

    if (hasId) {
      updateProduct(product);
    } else {
      insertOnProductList(product);
    }
  }

  void insertOnProductList(Product product) {
    _items.add(product);
    notifyListeners(); // Notifica aos subscribers que houve uma modificação nos dados dessa classe;
  }

  void updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      _items.removeWhere((item) => item.id == product.id);
      notifyListeners();
    }
  }
}
