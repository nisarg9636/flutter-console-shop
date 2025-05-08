
import 'package:flutter/material.dart';
import '../models/shop_item.dart';

class CartScreen extends StatelessWidget {
  final List<ShopItem> cart;

  CartScreen(this.cart);

  @override
  Widget build(BuildContext context) {
    final total = cart.fold(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      appBar: AppBar(
        title: Text('🛒 Your Cart'),
        backgroundColor: Colors.cyan,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...cart.map((item) => ListTile(
                leading: Image.asset(item.imagePath, width: 40),
                title: Text(item.name),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
              )),
          SizedBox(height: 20),
          Center(
            child: Text(
              'Total: \$${total.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
