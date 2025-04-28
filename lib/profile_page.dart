import 'package:flutter/material.dart';
import 'order_form.dart'; // Import the order form page
import 'cart_page.dart'; // Import CartItem class

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "John Doe";
  String _email = "john.doe@example.com";
  final int _rewardPoints = 325;
  bool _isEditing = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Order history data
  final List<Order> _orderHistory = [
    Order(
      id: "ORD-4892",
      date: "May 1, 2023",
      total: 12.47,
      status: "Delivered",
      items: ["Cappuccino x1", "Croissant x1"],
    ),
    Order(
      id: "ORD-3921",
      date: "April 28, 2023",
      total: 18.95,
      status: "Delivered",
      items: ["Latte x2", "Mocha x1", "Blueberry Muffin x1"],
    ),
    Order(
      id: "ORD-2854",
      date: "April 22, 2023",
      total: 9.99,
      status: "Delivered",
      items: ["Cold Brew x1", "Chocolate Chip Cookie x2"],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _nameController.text = _name;
    _emailController.text = _email;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY PROFILE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  // Save changes
                  _name = _nameController.text;
                  _email = _emailController.text;
                } else {
                  // Enter edit mode
                  _nameController.text = _name;
                  _emailController.text = _email;
                }
                _isEditing = !_isEditing;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary,
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.white70,
                          child: Icon(
                            Icons.person,
                            size: 80,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        if (_isEditing)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 18,
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt, size: 18),
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Change profile picture feature coming soon!',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isEditing)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              controller: _emailController,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white70),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        children: [
                          Text(
                            _name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _email,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Reward Points: $_rewardPoints",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tabs for different profile sections
            DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    tabs: const [Tab(text: 'ACCOUNT'), Tab(text: 'ORDERS')],
                  ),
                  SizedBox(
                    height: 500, // Fixed height for the tab content
                    child: TabBarView(
                      children: [
                        // Account tab content
                        ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _buildProfileMenuItem(
                              Icons.favorite,
                              "Favorite Orders",
                              "Quick access to your favorite coffee orders",
                            ),
                            _buildProfileMenuItem(
                              Icons.payment,
                              "Payment Methods",
                              "Manage your payment options",
                            ),
                            _buildProfileMenuItem(
                              Icons.location_on,
                              "Delivery Addresses",
                              "Manage your delivery locations",
                            ),
                            _buildProfileMenuItem(
                              Icons.settings,
                              "Settings",
                              "App preferences and notification settings",
                            ),
                            _buildProfileMenuItem(
                              Icons.help,
                              "Help & Support",
                              "Get help with your orders or account",
                            ),
                            const SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade400,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                ),
                                child: const Text("Sign Out"),
                              ),
                            ),
                          ],
                        ),

                        // Orders tab content
                        _orderHistory.isEmpty
                            ? const Center(child: Text("No orders yet"))
                            : ListView.builder(
                              itemCount: _orderHistory.length,
                              itemBuilder: (context, index) {
                                return _buildOrderItem(_orderHistory[index]);
                              },
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: 28,
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildOrderItem(Order order) {
    Color statusColor;
    switch (order.status.toLowerCase()) {
      case "delivered":
        statusColor = Colors.green;
        break;
      case "in progress":
        statusColor = Colors.orange;
        break;
      case "cancelled":
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.blue;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        title: Text(
          "Order #${order.id}",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${order.date} · \$${order.total.toStringAsFixed(2)}"),
        trailing: Chip(
          label: Text(
            order.status,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor: statusColor.withOpacity(0.1),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Items:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...order.items.map((item) => Text("• $item")),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Total:"),
                    Text(
                      "\$${order.total.toStringAsFixed(2)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (order.status == "Delivered")
                  OutlinedButton(
                    onPressed: () {
                      _reorderItems(order);
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: const Text("REORDER"),
                  )
                else
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey,
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text("VIEW DETAILS"),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Add a new method to handle reordering
  void _reorderItems(Order order) {
    // Convert order items to CartItem objects
    final List<CartItem> cartItems = _convertToCartItems(order.items);

    // Calculate values for the order form
    double subtotal = order.total * 0.85; // Approximate subtotal from total
    double tax = subtotal * 0.08;
    double deliveryFee = 2.50;
    double total = subtotal + tax + deliveryFee;

    // Navigate to the order form
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => OrderFormPage(
              cartItems: cartItems,
              subtotal: subtotal,
              tax: tax,
              deliveryFee: deliveryFee,
              total: total,
            ),
      ),
    );
  }

  // Helper method to convert order item strings to CartItem objects
  List<CartItem> _convertToCartItems(List<String> items) {
    List<CartItem> result = [];

    // Map of item images for commonly ordered items - use asset paths instead of URLs
    final Map<String, String> itemImages = {
      'Cappuccino': 'assets/images/cappuccino.jpg',
      'Latte': 'assets/images/latte.jpg',
      'Mocha': 'assets/images/mocha.jpg',
      'Cold Brew': 'assets/images/cold_brew.jpg',
      'Croissant': 'assets/images/croissant.jpg',
      'Cookie': 'assets/images/cookie.jpg',
      'Muffin': 'assets/images/muffin.jpg',
    };

    // Default image path to use if specific image is not found
    const String defaultImage = 'assets/images/default_coffee.jpg';

    // Process each item string (format: "ItemName xQuantity")
    for (String item in items) {
      final parts = item.split(' x');
      if (parts.length == 2) {
        final name = parts[0];
        final quantity = int.tryParse(parts[1]) ?? 1;

        // Find image or use default
        String image = defaultImage;
        itemImages.forEach((key, value) {
          if (name.contains(key)) {
            image = value;
          }
        });

        // Set price based on item type
        double price = 0.0;
        if (name.contains('Cappuccino')) {
          price = 3.99;
        } else if (name.contains('Latte')) {
          price = 4.29;
        } else if (name.contains('Mocha')) {
          price = 4.49;
        } else if (name.contains('Cold Brew')) {
          price = 3.99;
        } else if (name.contains('Croissant')) {
          price = 2.99;
        } else if (name.contains('Cookie')) {
          price = 2.49;
        } else if (name.contains('Muffin')) {
          price = 3.49;
        } else {
          price = 3.99; // Default price
        }

        // Create CartItem with local asset image
        result.add(
          CartItem(
            name: name,
            price: price,
            image: image,
            quantity: quantity,
            options: "Regular",
            useAssetImage: true, // Flag to indicate this is an asset image
          ),
        );
      }
    }

    return result;
  }
}

class Order {
  final String id;
  final String date;
  final double total;
  final String status;
  final List<String> items;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.status,
    required this.items,
  });
}
