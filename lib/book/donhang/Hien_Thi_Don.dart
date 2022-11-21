import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../shared/app_drawer.dart';
import 'Don_Hang.dart';
import 'Them_Don_Hang.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrderScreen({super.key});

  Widget build(BuildContext context) {
    print('building orders');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đơn Hàng'),
      ),
      body: Container(
        child: Consumer<OrdersManager>(
          builder: (ctx, ordersManager, child) {
            return ListView.builder(
              itemCount: ordersManager.orderCount,
              itemBuilder: (ctx, i) => OrderItemCard(ordersManager.orders[i]),
            );
          },
        ),
      ),
    );
  }
}
