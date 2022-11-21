import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/product.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  const ProductDetailScreen(this.product, {super.key});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 400,
                width: double.infinity,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${product.price}\Đ',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '\Tên tác giả: ${product.author}',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '\Ngày Cập Nhật: ${DateFormat('dd-MM-yyyy').format(product.dateTime)}',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(
                  '\Giới Thiệu Về Sách: ${product.description}',
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: "DancingScript",
                      fontStyle: FontStyle.italic),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
