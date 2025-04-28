import 'package:flutter/material.dart';
import 'cart_page.dart';

class OrderFormPage extends StatefulWidget {
  final List<CartItem> cartItems;
  final double subtotal;
  final double tax;
  final double deliveryFee;
  final double total;

  const OrderFormPage({
    super.key,
    required this.cartItems,
    required this.subtotal,
    required this.tax,
    required this.deliveryFee,
    required this.total,
  });

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  String _paymentMethod = 'Credit Card';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'CHECKOUT',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Delivery Address',
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your delivery address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: 'Special Instructions (Optional)',
                    prefixIcon: const Icon(Icons.note),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Payment Method',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildPaymentMethodSelector(),
                const SizedBox(height: 24),
                const Text(
                  'Order Summary',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildOrderSummaryCard(),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'PLACE ORDER',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodSelector() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(
                    Icons.credit_card,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text('Credit Card'),
                ],
              ),
              value: 'Credit Card',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(
                    Icons.payment,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text('Cash on Delivery'),
                ],
              ),
              value: 'Cash on Delivery',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
            RadioListTile<String>(
              title: Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text('Mobile Payment'),
                ],
              ),
              value: 'Mobile Payment',
              groupValue: _paymentMethod,
              onChanged: (value) {
                setState(() {
                  _paymentMethod = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummaryCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal'),
                Text('\$${widget.subtotal.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tax'),
                Text('\$${widget.tax.toStringAsFixed(2)}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Delivery Fee'),
                Text('\$${widget.deliveryFee.toStringAsFixed(2)}'),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  '\$${widget.total.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitOrder() {
    if (_formKey.currentState!.validate()) {
      // Show a success dialog
      showDialog(
        context: context,
        barrierDismissible: false,
        builder:
            (context) => AlertDialog(
              title: Row(
                children: [
                  Icon(Icons.check_circle, color: Colors.green[700]),
                  const SizedBox(width: 8),
                  const Text("Order Placed!"),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your order has been placed successfully. You will receive a notification when your order is ready.",
                  ),
                  const SizedBox(height: 16),
                  Text("Delivery Address: ${_addressController.text}"),
                  Text("Payment Method: $_paymentMethod"),
                  const SizedBox(height: 8),
                  Text(
                    "Estimated delivery time: ${DateTime.now().hour + 1}:${DateTime.now().minute.toString().padLeft(2, '0')}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to home screen and clear cart
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text("DONE"),
                ),
              ],
            ),
      );
    }
  }
}
