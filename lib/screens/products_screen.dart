import 'package:dev_store/components/app_drawer.dart';
import 'package:dev_store/components/product_item.dart';
import 'package:dev_store/models/product_list.dart';
import 'package:dev_store/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    return Provider.of<ProductList>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductList productsList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: productsList.itemsCount,
            itemBuilder: (ctx, i) => Column(
              children: [
                ProductItem(product: productsList.products[i]),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
