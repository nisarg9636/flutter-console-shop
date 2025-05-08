
import 'package:flutter/material.dart';
import '../models/shop_item.dart';

class WishlistScreen extends StatelessWidget {
  final List<ShopItem> wishlist;

  WishlistScreen(this.wishlist);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('💖 Wishlist'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final item = wishlist[index];
          return Card(
            child: ListTile(
              leading: Image.asset(item.imagePath, width: 40),
              title: Text(item.name),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
