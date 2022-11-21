import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_product_screen.dart';
import 'Edit_Delete_SP.dart';
import '../shared/app_drawer.dart';
import 'Quan_Ly_SP.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductsScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await context.read<ProductsManager>().fetchProducts(true);
  }

  Widget build(BuildContext context) {
    final productsManager = ProductsManager();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Sản Phẩm'),
        actions: <Widget>[
          // buildAddButton(context),
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: buildUserProductListView(),
            );
          },
        ),
      ),
    );
  }

  Widget buildUserProductListView() {
    return Consumer<ProductsManager>(
      builder: (ctx, productsManager, child) {
        return ListView.builder(
          itemCount: productsManager.itemCount,
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductListTile(
                productsManager.items[i],
              ),
              const Divider(),
            ],
          ),
        );
      },
    );
  }

  Widget buildAddButton(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.add),
      onPressed: () {
        Navigator.of(context).pushNamed(
          EditProductScreen.routeName,
        );
      },
    );
  }
}
