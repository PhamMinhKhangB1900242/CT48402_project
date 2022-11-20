import 'package:flutter/material.dart';
import 'package:myshop/ui/giohang/Quan_Ly_Gio.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';
import '../sanpham/Them_Hoan_Tac_SP.dart';

import '../../models/cart_item.dart';
import '../shared/dialog_utils.dart';

class CartItemCard extends StatelessWidget {
  final String productId;
  final CartItem cardItem;

  const CartItemCard({
    required this.productId,
    required this.cardItem,
    super.key,
  });

  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cardItem.id),
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showConfirmDialog(
            context, 'Bạn có muốn xóa sản phẩm khỏi giỏ hàng không?');
      },
      onDismissed: (direction) {
        context.read<CartManager>().removeItem(productId);
      },
      child: buildItemCard(),
    );
  }

  Widget buildItemCard() {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Color.fromARGB(255, 54, 244, 219),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: ClipOval(
                  child: Image.network(
                      'https://png.pngtree.com/png-clipart/20190705/original/pngtree-shopping-cart-icon-design-png-image_4362857.jpg')),
            ),
          ),
          title: Text(cardItem.title),
          subtitle: Text('Tổng tiền ${(cardItem.price * cardItem.quantity)}\Đ'),
          trailing: Text('${cardItem.quantity} x'),
        ),
      ),
    );
  }
}
