import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import 'Them_Hoan_Tac_SP.dart';
import 'Quan_Ly_SP.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorite;
  const ProductsGrid(this.showFavorite, {super.key});
  @override
  Widget build(BuildContext context) {
    final products = context.select<ProductsManager, List<Product>>(
        (productsManager) => showFavorite
            ? productsManager.favoriteItems
            : productsManager.items);
    final productsManager = ProductsManager();

    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}
