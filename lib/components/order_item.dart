import 'package:dev_store/models/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({super.key, required this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('R\$ ${widget.order.total.toStringAsFixed(2)}'),
            subtitle: Text(DateFormat('dd/MM/yyyy').format(widget.order.date)),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {
                setState(() {
                  expanded = !expanded;
                });
              },
            ),
          ),
          if (expanded)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
              height: (widget.order.products.length * 25) + 10,
              child: ListView(
                children: widget.order.products.map((product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.title,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${product.quantity}x R\$ ${product.price}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                }).toList(),
              ),
            )
        ],
      ),
    );
  }
}
