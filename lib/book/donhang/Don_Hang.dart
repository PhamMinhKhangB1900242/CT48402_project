import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;
  const OrderItemCard(this.order, {super.key});

  State<OrderItemCard> createState() => _OrderItemcardState();
}

class _OrderItemcardState extends State<OrderItemCard> {
  var _expanded = false;

  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          if (_expanded) buildOrderDetails()
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      height: min(widget.order.productCount * 20.0 + 100, 300),
      child: ListView(
        children: widget.order.products
            .map(
              (prod) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    prod.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${prod.quantity}x ${prod.price}\Đ',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildOrderSummary() {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Color.fromARGB(255, 232, 62, 23),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ClipOval(
              child: Image.network(
                  'https://png.pngtree.com/png-clipart/20210418/original/pngtree-vector-icon-sale-png-image_6233640.jpg')),
        ),
      ),
      title: Text('${widget.order.amount}\Đ'),
      subtitle: Text(
        DateFormat('dd/mm/yyyy hh:mm').format(widget.order.dateTime),
      ),
      trailing: IconButton(
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
      ),
    );
  }
}
