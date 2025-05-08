import 'package:flutter/material.dart';
import '../models/shop_item.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<ShopItem> items = [
    ShopItem(name: 'Game Console', price: 299.99, imagePath: 'assets/console.png'),
    ShopItem(name: 'Wireless Controller', price: 59.99, imagePath: 'assets/controller.png'),
    ShopItem(name: 'Gamepad Pro', price: 39.99, imagePath: 'assets/gamepad.png'),
  ];

  final List<ShopItem> cart = [];
  final List<ShopItem> wishlist = [];

  void addToCart(ShopItem item) {
    setState(() {
      if (!cart.contains(item)) cart.add(item);
    });
  }

  void removeFromCart(ShopItem item) {
    setState(() {
      cart.remove(item);
    });
  }

  void addToWishlist(ShopItem item) {
    setState(() {
      if (!wishlist.contains(item)) wishlist.add(item);
    });
  }

  void removeFromWishlist(ShopItem item) {
    setState(() {
      wishlist.remove(item);
    });
  }

  double get total => cart.fold(0, (sum, item) => sum + item.price);

  void navigateToList(String title, List<ShopItem> list, void Function(ShopItem) onRemove) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            return Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                leading: Image.asset(item.imagePath, width: 50),
                title: Text(item.name),
                subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    onRemove(item);
                    Navigator.of(context).pop(); // close and refresh screen
                    navigateToList(title, list, onRemove); // reopen with updated list
                  },
                ),
              ),
            );
          },
        ),
      ),
    ));
  }

  Widget buildItemCard(ShopItem item, double width) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Image.asset(item.imagePath, fit: BoxFit.contain),
            ),
            SizedBox(height: 8),
            Text(item.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                textAlign: TextAlign.center),
            Text('\$${item.price.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.cyan, fontWeight: FontWeight.w600)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.pinkAccent),
                  onPressed: () => addToWishlist(item),
                ),
                IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Colors.cyan),
                  onPressed: () => addToCart(item),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('🎮 Console Store', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyan.shade700,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.pinkAccent),
            onPressed: () => navigateToList('Wishlist', wishlist, removeFromWishlist),
            tooltip: 'View Wishlist',
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () => navigateToList('Shopping Cart', cart, removeFromCart),
            tooltip: 'View Cart',
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '\$${total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLandscape
            ? SizedBox(
          height: 250,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(width: 16),
            itemBuilder: (context, index) =>
                buildItemCard(items[index], 200),
          ),
        )
            : ListView.separated(
          itemCount: items.length,
          separatorBuilder: (_, __) => SizedBox(height: 16),
          itemBuilder: (context, index) =>
              buildItemCard(items[index], screenWidth - 32),
        ),
      ),
    );
  }
}
