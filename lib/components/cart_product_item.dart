import 'package:dev_store/models/cart.dart';
import 'package:dev_store/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartProductItem extends StatelessWidget {
  final CartItem cartItem;

  const CartProductItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItem.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(cartItem.id);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: FittedBox(child: Text('R\$ ${cartItem.price}')),
              ),
            ),
            title: Text(cartItem.title),
            subtitle: Text('${cartItem.price * cartItem.quantity}'),
            trailing: Text('${cartItem.quantity}x'),
          ),
        ),
      ),
    );
  }
}
