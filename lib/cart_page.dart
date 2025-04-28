import 'package:flutter/material.dart';
import 'order_form.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<CartItem> _cartItems = [
    CartItem(
      name: "Cappuccino",
      price: 3.99,
      image:
          "https://images.unsplash.com/photo-1495231916356-a86217efff12?w=500",
      quantity: 1,
      options: "Medium, Extra shot, Oat milk",
    ),
    CartItem(
      name: "Mocha",
      price: 4.49,
      image:
          "https://images.unsplash.com/photo-1579888944880-d98341245702?w=500",
      quantity: 2,
      options: "Large, Whipped cream",
    ),
    CartItem(
      name: "Croissant",
      price: 2.99,
      image: "https://images.unsplash.com/photo-1549903072-7e6e0bedb7fb?w=500",
      quantity: 1,
      options: "Butter, Warmed",
    ),
  ];

  double get _subtotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  double get _tax => _subtotal * 0.08; // 8% tax rate
  double get _deliveryFee => 2.50;
  double get _total => _subtotal + _tax + _deliveryFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'YOUR CART',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: _cartItems.isEmpty ? _buildEmptyCart() : _buildCartWithItems(),
      bottomNavigationBar: _cartItems.isEmpty ? null : _buildCheckoutBar(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 100,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 20),
          Text(
            "Your cart is empty",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Add something from the menu",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.menu_book),
            label: const Text("Browse Menu"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartWithItems() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _cartItems.length,
            itemBuilder: (context, index) {
              return _buildCartItem(_cartItems[index], index);
            },
          ),
        ),
        _buildOrderSummary(),
      ],
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Dismissible(
      key: Key(item.name + index.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        setState(() {
          _cartItems.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.name} removed from cart'),
            action: SnackBarAction(
              label: 'UNDO',
              onPressed: () {
                setState(() {
                  _cartItems.insert(index, item);
                });
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    item.useAssetImage
                        ? Image.asset(
                          item.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback if asset image fails
                            return Container(
                              width: 80,
                              height: 80,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              child: Icon(
                                Icons.coffee,
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                              ),
                            );
                          },
                        )
                        : Image.network(
                          item.image,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            // Fallback if network image fails
                            return Container(
                              width: 80,
                              height: 80,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withOpacity(0.1),
                              child: Icon(
                                Icons.coffee,
                                color: Theme.of(context).colorScheme.primary,
                                size: 40,
                              ),
                            );
                          },
                        ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red.shade400,
                          onPressed: () {
                            setState(() {
                              _cartItems.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${item.name} removed from cart'),
                                action: SnackBarAction(
                                  label: 'UNDO',
                                  onPressed: () {
                                    setState(() {
                                      _cartItems.insert(index, item);
                                    });
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    if (item.options.isNotEmpty)
                      Text(
                        item.options,
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            _buildQuantityButton(
                              icon: Icons.remove,
                              onPressed:
                                  item.quantity > 1
                                      ? () {
                                        setState(() {
                                          item.quantity--;
                                        });
                                      }
                                      : null,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              child: Text(
                                item.quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            _buildQuantityButton(
                              icon: Icons.add,
                              onPressed: () {
                                setState(() {
                                  item.quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color:
            onPressed == null
                ? Colors.grey.shade300
                // ignore: deprecated_member_use
                : Theme.of(context).colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, size: 16),
        onPressed: onPressed,
        color:
            onPressed == null
                ? Colors.grey.shade500
                : Theme.of(context).colorScheme.primary,
        constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Order Summary",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow("Subtotal", _subtotal),
          const SizedBox(height: 8),
          _buildSummaryRow("Tax (8%)", _tax),
          const SizedBox(height: 8),
          _buildSummaryRow("Delivery Fee", _deliveryFee),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "\$${_total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey.shade700)),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: ElevatedButton(
          onPressed: () {
            _showConfirmationDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            "CHECKOUT",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Confirm Order"),
            content: Text(
              "Place your order for \$${_total.toStringAsFixed(2)}?",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCEL"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Navigate to order form instead of directly showing success
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => OrderFormPage(
                            cartItems: _cartItems,
                            subtotal: _subtotal,
                            tax: _tax,
                            deliveryFee: _deliveryFee,
                            total: _total,
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: const Text("PROCEED TO CHECKOUT"),
              ),
            ],
          ),
    );
  }
}

class CartItem {
  final String name;
  final double price;
  final String image;
  int quantity;
  final String options;
  final bool useAssetImage;

  CartItem({
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
    required this.options,
    this.useAssetImage = false,
  });
}
