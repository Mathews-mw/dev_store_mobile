import 'dart:convert';

import 'package:dev_store/exceptions/http_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final _dbBaseUrl = 'https://shop-coder-8a8b3-default-rtdb.firebaseio.com';

  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() async {
    isFavorite = !isFavorite;
    notifyListeners();

    final response = await http.patch(
      Uri.parse('$_dbBaseUrl/products/$id.json'),
      body: jsonEncode({"isFavorite": isFavorite}),
    );

    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      throw HttpExceptions(
        msg: 'Não foi possível marcar como favorito.',
        statusCode: response.statusCode,
      );
    }
  }
}
