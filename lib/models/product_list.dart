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

  void addProduct(Product product) {
    _items.add(product);
    notifyListeners(); // Notifica aos subscribers que houve uma modificação nos dados dessa classe;
  }
}
