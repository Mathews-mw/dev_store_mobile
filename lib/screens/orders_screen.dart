import 'package:dev_store/components/app_drawer.dart';
import 'package:dev_store/components/order_item.dart';
import 'package:dev_store/models/order_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
          future: Provider.of<OrderList>(context, listen: false).loadOrders(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.error != null) {
              return const Center(child: Text('Ocorreu algum erro...'));
            } else {
              return Consumer<OrderList>(
                builder: (ctx, orders, child) => ListView.builder(
                  itemCount: orders.itemsCount,
                  itemBuilder: (ctx, index) =>
                      OrderItem(order: orders.listOrder[index]),
                ),
              );
            }
          }),
    );
  }
}
