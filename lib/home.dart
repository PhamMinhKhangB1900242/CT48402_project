import 'package:flutter/material.dart';
import 'package:myshop/ui/auth/auth_manager.dart';
import 'package:myshop/ui/giohang/Quan_Ly_Gio.dart';
import 'package:myshop/ui/giohang/Hien_Thi_Gio.dart';
import 'package:myshop/ui/donhang/Hien_Thi_Don.dart';
import 'package:myshop/ui/sanpham/Danh_Muc.dart';
import 'package:myshop/ui/sanpham/edit_product_screen.dart';
import 'package:myshop/ui/sanpham/Hien_Thi_Tong_Quan_SP.dart';
import 'package:myshop/ui/sanpham/Khung_San_Pham.dart';
import 'package:myshop/ui/sanpham/Quan_Ly_SP.dart';
import 'package:myshop/ui/sanpham/Chinh_Sua_San_Pham.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:provider/provider.dart';
import 'ui/shared/app_drawer.dart';
import 'ui/sanpham/Khung_San_Pham.dart';
import 'ui/giohang/Quan_Ly_Gio.dart';
import 'ui/sanpham/top_right_badge.dart';

enum FilterOptions { favorites, all }

class home extends StatefulWidget {
  static const routeName = '/home';

  const home({super.key});
  @override
  State<home> createState() => _home();
}

class _home extends State<home> {
  final _showOnlyFavorites = ValueNotifier<bool>(false);
  late Future<void> _fetchProducts;

  @override
  void initState() {
    super.initState();
    _fetchProducts = context.read<ProductsManager>().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'BOOK SHOP',
          ),
        ),
        body: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: <Widget>[
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ProductsOverviewScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.favorite,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(
                        'Sản Phẩm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add_box,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(
                        'Thêm Sản Phẩm',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(
                        'Giỏ Hàng',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => ListTileSelectExample(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.article,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(
                        'Danh Mục ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(UserProductsScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.edit,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(
                        'Sửa Xoá Sản Phẩm ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(OrderScreen.routeName);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.other_houses,
                        color: Colors.pink,
                        size: 24.0,
                      ),
                      Text(
                        'Đơn Hàng',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget buildShoppingCartIcon() {
    return Consumer<CartManager>(
      builder: (ctx, cartManager, child) {
        return TopRightBadge(
          data: cartManager.productCount,
          child: IconButton(
            icon: const Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              Navigator.of(ctx).pushNamed(CartScreen.routeName);
            },
          ),
        );
      },
    );
  }

  Widget buildProductFilterMenu() {
    return PopupMenuButton(
      onSelected: (FilterOptions selectedValue) {
        if (selectedValue == FilterOptions.favorites) {
          _showOnlyFavorites.value = true;
        } else {
          _showOnlyFavorites.value = false;
        }
      },
      icon: const Icon(
        Icons.more_vert,
      ),
      itemBuilder: (ctx) => [
        const PopupMenuItem(
          value: FilterOptions.favorites,
          child: Text('Only Favorites'),
        ),
        const PopupMenuItem(
          value: FilterOptions.all,
          child: Text('Show all'),
        ),
      ],
    );
  }
}
