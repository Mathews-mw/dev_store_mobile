import 'package:dev_store/components/cart_product_item.dart';
import 'package:dev_store/models/cart.dart';
import 'package:dev_store/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final cartItems = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho de compras'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(width: 10),
                  Chip(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    label: Text(
                      'R\$ ${cart.totalAmount}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onPressed: () {
                      Provider.of<OrderList>(context, listen: false)
                          .addOrder(cart);

                      cart.clear();
                    },
                    child: const Text('COMPRAR'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (ctx, index) =>
                  CartProductItem(cartItem: cartItems[index]),
            ),
          ),
        ],
      ),
    );
  }
}
