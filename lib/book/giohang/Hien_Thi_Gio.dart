import 'package:flutter/material.dart';
import 'package:myshop/book/donhang/Them_Don_Hang.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'Quan_Ly_Gio.dart';
import 'SP_Trong_Gio.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  const CartScreen({super.key});

  Widget build(BuildContext context) {
    final cart = context.watch<CartManager>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giỏ Hàng'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            buildCartSummary(cart, context),
            buildCartBut(cart, context),
            const SizedBox(height: 10),
            Expanded(
              child: buildCartDetails(cart),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartDetails(CartManager cart) {
    return ListView(
      children: cart.productEntries
          .map(
            (entry) => CartItemCard(
              productId: entry.key,
              cardItem: entry.value,
            ),
          )
          .toList(),
    );
  }

  Widget buildCartSummary(CartManager cart, BuildContext context) {
    return Card(
      color: Colors.lightBlueAccent,
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Tổng Đơn Hàng',
              style: TextStyle(fontSize: 20),
            ),
            const Spacer(),
            Chip(
              label: Text(
                '${cart.totalAmount.toStringAsFixed(0)}\Đ',
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline6?.color,
                ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartBut(CartManager cart, BuildContext context) {
    return Container(
      child: OutlinedButton.icon(
        onPressed: cart.totalAmount <= 0
            ? null
            : () {
                context.read<OrdersManager>().addOrder(
                      cart.products,
                      cart.totalAmount,
                    );
                cart.clear();
              },
        style: OutlinedButton.styleFrom(
          textStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        label: const Text(
          'ĐẶT HÀNG NGAY',
          style: TextStyle(fontSize: 20),
        ),
        icon: Icon(Icons.shopping_cart_checkout_outlined),
      ),
    );
  }
}
