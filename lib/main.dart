import 'package:flutter/material.dart';

// Entry point of the Flutter app
void main() {
  runApp(ShopApp());
}

// A model class to represent each item in the shop
class ShopItem {
  final String name;
  final double price;
  final String imagePath;

  ShopItem({required this.name, required this.price, required this.imagePath});
}

// The main widget that sets up the app's theme and home page
class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Console Shop',
      // Dark theme with cyan accent look
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[900],
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: ShopHomePage(), // Set the homepage
    );
  }
}

// The home page is a stateful widget because the cart changes dynamically
class ShopHomePage extends StatefulWidget {
  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  // List of available shop items
  final List<ShopItem> items = [
    ShopItem(name: 'Game Console', price: 299.99, imagePath: 'assets/console.png'),
    ShopItem(name: 'Wireless Controller', price: 59.99, imagePath: 'assets/controller.png'),
    ShopItem(name: 'Gamepad Pro', price: 39.99, imagePath: 'assets/gamepad.png'),
  ];

  // Items added to the shopping cart
  final List<ShopItem> cart = [];

  // Function to add an item to the cart
  void addToCart(ShopItem item) {
    setState(() {
      cart.add(item); // Triggers UI update
    });
  }

  // Calculate total price of items in the cart
  double get total => cart.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with title and cart total
      appBar: AppBar(
        title: Text('🎮 Console Store', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.cyan.shade700,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                '🛒 \$${total.toStringAsFixed(2)}', // Real-time cart total
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        ],
      ),

      // List of shop items with separators
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: items.length,
        separatorBuilder: (_, __) => SizedBox(height: 12), // Spacing between items
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: Image.asset(item.imagePath, width: 50), // Show item image
              title: Text(item.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              subtitle: Text('\$${item.price.toStringAsFixed(2)}', style: TextStyle(color: Colors.cyanAccent)),
              trailing: ElevatedButton.icon(
                icon: Icon(Icons.add_shopping_cart),
                label: Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => addToCart(item), // Add item to cart when clicked
              ),
            ),
          );
        },
      ),
    );
  }
}
