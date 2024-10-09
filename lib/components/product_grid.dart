import 'package:dev_store/components/product_item.dart';
import 'package:dev_store/models/product.dart';
import 'package:dev_store/models/product_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productListProvider = Provider.of<ProductList>(context);
    final List<Product> loadProducts = productListProvider.products;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadProducts.length,
      itemBuilder: (ctx, index) => ProductItem(product: loadProducts[index]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
