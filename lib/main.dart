import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myshop/home.dart';
import 'package:myshop/book/giohang/Quan_Ly_Gio.dart';
import 'package:myshop/book/donhang/Them_Don_Hang.dart';
import 'package:myshop/book/sanpham/edit_product_screen.dart';
import 'package:provider/provider.dart';
import 'book/sanpham/Chi_Tiet_San_Pham.dart';
import 'book/sanpham/Quan_Ly_SP.dart';
import 'book/sanpham/Hien_Thi_Tong_Quan_SP.dart';
import 'book/sanpham/Chinh_Sua_San_Pham.dart';
import 'book/giohang/Hien_Thi_Gio.dart';
import 'book/donhang/Hien_Thi_Don.dart';

import 'book/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsMAnager) {
            productsMAnager!.authToken = authManager.authToken;
            return productsMAnager;
          },
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrdersManager(),
        ),
      ],
      child: Consumer<AuthManager>(builder: (context, authManager, child) {
        return MaterialApp(
          title: 'BOOK SHOP',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Lato',
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.blue,
            ).copyWith(
              secondary: Color.fromARGB(255, 29, 84, 211),
            ),
          ),
          home: authManager.isAuth
              ? const home()
              : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: (context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  },
                ),
          routes: {
            home.routeName: (context) => const home(),
            CartScreen.routeName: (ctx) => const CartScreen(),
            OrderScreen.routeName: (ctx) => const OrderScreen(),
            UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name == EditProductScreen.routeName) {
              final productId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return EditProductScreen(
                    productId != null
                        ? ctx.read<ProductsManager>().findById(productId)
                        : null,
                  );
                },
              );
            }
            return null;
          },
        );
      }),
    );
  }
}
