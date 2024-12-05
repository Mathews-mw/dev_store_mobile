import 'dart:math';
import 'dart:convert';
import 'package:dev_store/exceptions/http_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dev_store/models/product.dart';

class ProductList with ChangeNotifier {
  final _dbBaseUrl = 'https://shop-coder-8a8b3-default-rtdb.firebaseio.com';
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

    final response = await http.get(Uri.parse('$_dbBaseUrl/products.json'));

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
      Uri.parse('$_dbBaseUrl/products.json'),
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

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('$_dbBaseUrl/products/${product.id}.json'),
        body: jsonEncode({
          "title": product.title,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
          "isFavorite": product.isFavorite
        }),
      );

      _items[index] = product;

      notifyListeners(); // Notifica aos subscribers que houve uma modificação nos dados dessa classe;
    }
  }

  Future<void> removeProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);

    if (index >= 0) {
      final product = _items[index];

      _items.remove(product);
      notifyListeners();

      final response = await http
          .delete(Uri.parse('$_dbBaseUrl/products/${product.id}.json'));

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();

        throw HttpExceptions(
          msg:
              'Houve um erro ao tentar deletar o produto, por favor tente novamente.',
          statusCode: response.statusCode,
        );
      }
    }
  }
}
