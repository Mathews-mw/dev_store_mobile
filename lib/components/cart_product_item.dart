import 'package:dev_store/models/cart_item.dart';
import 'package:flutter/material.dart';

class CartProductItem extends StatelessWidget {
  final CartItem cartItem;

  const CartProductItem({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Text(cartItem.title);
  }
}
