import 'package:dev_store/components/product_item.dart';
import 'package:dev_store/data/dummy_data.dart';
import 'package:dev_store/models/product.dart';
import 'package:flutter/material.dart';

class ProductsOverviewScreen extends StatelessWidget {
  final List<Product> loadProducts = dummyProducts;

  ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadProducts.length,
        itemBuilder: (ctx, index) => ProductItem(product: loadProducts[index]),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
    );
  }
}
