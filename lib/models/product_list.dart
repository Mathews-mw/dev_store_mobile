import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dev_store/models/product.dart';

class ProductList with ChangeNotifier {
  final _dbBaseUrl =
      'https://shop-coder-8a8b3-default-rtdb.firebaseio.com/products.json';
  final List<Product> _items = [];

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

  Future<void> loadProducts() async {
    _items.clear();

    final response = await http.get(Uri.parse(_dbBaseUrl));

    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);

    data.forEach((productId, productData) {
      _items.add(Product(
        id: productId,
        title: productData['title'],
        description: productData['description'],
        price: productData['price'],
        imageUrl: productData['imageUrl'],
        isFavorite: productData['isFavorite'],
      ));
    });

    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = Product(
        id: hasId ? data['id'] as String : Random().nextDouble().toString(),
        title: data['name'] as String,
        description: data['description'] as String,
        price: data['price'] as double,
        imageUrl: data['imageUrl'] as String);

    if (hasId) {
      return updateProduct(product);
    } else {
      return insertOnProductList(product);
    }
  }

  Future<void> insertOnProductList(Product product) async {
    final response = await http.post(
      Uri.parse(_dbBaseUrl),
      body: jsonEncode({
        "title": product.title,
        "description": product.description,
        "price": product.price,
        "imageUrl": product.imageUrl,
        "isFavorite": product.isFavorite
      }),
    );

    final id = jsonDecode(response.body)['name'];

    _items.add(Product(
      id: id,
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));

    notifyListeners();
  }

  Future<void> updateProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners(); // Notifica aos subscribers que houve uma modificação nos dados dessa classe;
    }

    return Future.value();
  }

  void removeProduct(Product product) {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      _items.removeWhere((item) => item.id == product.id);
      notifyListeners();
    }
  }
}
