import 'package:dev_store/components/product_grid.dart';
import 'package:dev_store/models/product.dart';
import 'package:dev_store/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<ProductList>(context);
    final List<Product> loadProducts = productListProvider.products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Loja'),
      ),
      body: ProductGrid(),
    );
  }
}
