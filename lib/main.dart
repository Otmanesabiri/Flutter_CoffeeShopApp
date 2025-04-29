import 'package:flutter/material.dart';

void main() {
  runApp(const CoffeeShopApp());
}

class CoffeeShopApp extends StatelessWidget {
  const CoffeeShopApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Haven',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF5D4037),
        scaffoldBackgroundColor: const Color(0xFFEFEBE9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF795548),
          primary: const Color(0xFF795548),
          secondary: const Color(0xFF5D4037),
          surface: const Color(0xFFEFEBE9),
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
          displayMedium: TextStyle(
            color: Color(0xFF3E2723),
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(color: Color(0xFF4E342E)),
          bodyMedium: TextStyle(color: Color(0xFF4E342E)),
        ),
      ),
      home: const MainScreen(),
      routes: {
        '/order_form': (context) => const OrderFormPage(),
        '/payment_methods': (context) => const PaymentMethodsPage(),
        '/order_history': (context) => const OrderHistoryPage(),
        '/delivery_addresses': (context) => const DeliveryAddressesPage(),
        '/notifications': (context) => const NotificationsPage(),
        '/settings': (context) => const SettingsPage(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CoffeeShopHomePage(),
    const MenuPage(),
    const FavoritesPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class CoffeeShopHomePage extends StatefulWidget {
  const CoffeeShopHomePage({super.key});
  @override
  State<CoffeeShopHomePage> createState() => _CoffeeShopHomePageState();
}

class _CoffeeShopHomePageState extends State<CoffeeShopHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<Coffee> _featuredCoffees = [
    Coffee(
      name: 'Espresso',
      price: 2.99,
      image:
          'https://images.unsplash.com/photo-1520031607889-97ba0c7190ff?w=500',
      description: 'Strong and rich Italian coffee',
      icon: Icons.coffee,
    ),
    Coffee(
      name: 'Cappuccino',
      price: 3.99,
      image:
          'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500',
      description: 'Classic Italian coffee with steamed milk',
      icon: Icons.coffee_maker,
    ),
    Coffee(
      name: 'Latte',
      price: 4.29,
      image:
          'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500',
      description: 'Espresso with steamed milk and a light layer of foam',
      icon: Icons.local_cafe,
    ),
    Coffee(
      name: 'Mocha',
      price: 4.49,
      image:
          'https://images.unsplash.com/photo-1572442388796-11668a67e53d?w=500',
      description: 'Espresso with chocolate and steamed milk',
      icon: Icons.local_drink,
    ),
  ];
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'COFFEE HAVEN',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero banner
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.network(
                        'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?w=500',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Center(
                    child: FadeTransition(
                      opacity: _animation,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Welcome to Coffee Haven',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Experience the perfect brew',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor:
                                  Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                            ),
                            icon: const Icon(Icons.coffee),
                            label: const Text('Order Now'),
                            onPressed: () {
                              Navigator.pushNamed(context, '/order_form');
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Categories section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _buildCategoryItem(Icons.coffee, 'Espresso'),
                        _buildCategoryItem(Icons.local_cafe, 'Latte'),
                        _buildCategoryItem(Icons.coffee_maker, 'Cappuccino'),
                        _buildCategoryItem(Icons.ac_unit, 'Cold Brew'),
                        _buildCategoryItem(Icons.cake, 'Pastries'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Featured coffees section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Coffees',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _featuredCoffees.length,
                    itemBuilder: (context, index) {
                      return _buildCoffeeItem(_featuredCoffees[index], index);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCoffeeItem(Coffee coffee, int index) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 * index,
            0.1 * index + 0.6,
            curve: Curves.easeOut,
          ),
        ),
      ),
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),
          leading: Hero(
            tag: 'coffee-${coffee.name}',
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(coffee.image),
            ),
          ),
          title: Text(
            coffee.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(coffee.description),
              const SizedBox(height: 4),
              Text(
                '\$${coffee.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          trailing: Icon(
            coffee.icon,
            color: Theme.of(context).colorScheme.primary,
            size: 28,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MENU',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildMenuCategory(context, 'Hot Coffee'),
          _buildCoffeeList(context, hotCoffees),
          _buildMenuCategory(context, 'Cold Coffee'),
          _buildCoffeeList(context, coldCoffees),
          _buildMenuCategory(context, 'Pastries'),
          _buildPastriesList(context),
        ],
      ),
    );
  }

  Widget _buildMenuCategory(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCoffeeList(BuildContext context, List<Coffee> coffees) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: coffees.length,
      itemBuilder: (context, index) {
        final coffee = coffees[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(coffee.image),
            ),
            title: Text(
              coffee.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('\$${coffee.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              color: Theme.of(context).colorScheme.primary,
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }

  Widget _buildPastriesList(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(12),
                ),
                child: Image.network(
                  'https://images.unsplash.com/photo-1559622214-f8a9850965bb?w=500',
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pastry ${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('\$${(2.99 + index * 0.5).toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 30),
                      ),
                      child: const Text('Add'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAVORITES',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  index == 0
                      ? 'https://images.unsplash.com/photo-1520031607889-97ba0c7190ff?w=500'
                      : index == 1
                      ? 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500'
                      : 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500',
                ),
              ),
              title: Text(
                index == 0
                    ? 'Espresso'
                    : index == 1
                    ? 'Cappuccino'
                    : 'Latte',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('\$${(2.99 + index * 0.5).toStringAsFixed(2)}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {},
                  ),
                ],
              ),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PROFILE',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          Center(
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'Coffee Lover',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: Text(
              'coffee.lover@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 30),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Order History'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/order_history'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.credit_card),
            title: const Text('Payment Methods'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/payment_methods'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Delivery Addresses'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/delivery_addresses'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/notifications'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () => Navigator.pushNamed(context, '/settings'),
          ),
          const Divider(),
          const SizedBox(height: 20),
          TextButton.icon(
            icon: const Icon(Icons.logout, color: Colors.red),
            label: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red, fontSize: 16),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

// Add new pages below

class OrderFormPage extends StatefulWidget {
  const OrderFormPage({super.key});

  @override
  State<OrderFormPage> createState() => _OrderFormPageState();
}

class _OrderFormPageState extends State<OrderFormPage> {
  String _selectedCoffee = 'Espresso';
  String _selectedSize = 'Medium';
  int _quantity = 1;
  bool _whippedCream = false;
  bool _extraShot = false;
  double _totalPrice = 2.99;

  final Map<String, double> _coffeeBasePrice = {
    'Espresso': 2.99,
    'Cappuccino': 3.99,
    'Latte': 4.29,
    'Mocha': 4.49,
  };

  final Map<String, double> _sizeMultiplier = {
    'Small': 0.8,
    'Medium': 1.0,
    'Large': 1.2,
  };

  void _updateTotalPrice() {
    double basePrice = _coffeeBasePrice[_selectedCoffee] ?? 2.99;
    double sizeMultiplier = _sizeMultiplier[_selectedSize] ?? 1.0;
    double extrasPrice =
        (_whippedCream ? 0.50 : 0.0) + (_extraShot ? 0.75 : 0.0);

    setState(() {
      _totalPrice = (basePrice * sizeMultiplier + extrasPrice) * _quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PLACE YOUR ORDER',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Coffee',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              isExpanded: true,
              value: _selectedCoffee,
              items:
                  _coffeeBasePrice.keys.map((String coffee) {
                    return DropdownMenuItem<String>(
                      value: coffee,
                      child: Text(coffee),
                    );
                  }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedCoffee = newValue;
                    _updateTotalPrice();
                  });
                }
              },
            ),
            const SizedBox(height: 16),

            const Text(
              'Select Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:
                  _sizeMultiplier.keys.map((size) {
                    return ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedSize = size;
                          _updateTotalPrice();
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            _selectedSize == size
                                ? Theme.of(context).colorScheme.primary
                                : Colors.grey[300],
                        foregroundColor:
                            _selectedSize == size ? Colors.white : Colors.black,
                      ),
                      child: Text(size),
                    );
                  }).toList(),
            ),

            const SizedBox(height: 16),
            const Text(
              'Quantity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed:
                      _quantity > 1
                          ? () {
                            setState(() {
                              _quantity--;
                              _updateTotalPrice();
                            });
                          }
                          : null,
                ),
                Text('$_quantity', style: const TextStyle(fontSize: 18)),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantity++;
                      _updateTotalPrice();
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Text(
              'Extras',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            CheckboxListTile(
              title: const Text('Whipped Cream (+\$0.50)'),
              value: _whippedCream,
              onChanged: (bool? value) {
                setState(() {
                  _whippedCream = value ?? false;
                  _updateTotalPrice();
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Extra Shot (+\$0.75)'),
              value: _extraShot,
              onChanged: (bool? value) {
                setState(() {
                  _extraShot = value ?? false;
                  _updateTotalPrice();
                });
              },
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\$${_totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Order placed successfully!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'PLACE ORDER',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  int _selectedCard = 0;
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'type': 'Visa',
      'number': '•••• •••• •••• 4242',
      'expiryDate': '05/25',
      'icon': Icons.credit_card,
      'color': Colors.blueAccent,
    },
    {
      'type': 'Mastercard',
      'number': '•••• •••• •••• 5555',
      'expiryDate': '09/24',
      'icon': Icons.credit_card,
      'color': Colors.orangeAccent,
    },
    {
      'type': 'PayPal',
      'number': 'coffee.lover@example.com',
      'expiryDate': '',
      'icon': Icons.account_balance_wallet,
      'color': Colors.blueGrey,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'PAYMENT METHODS',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color:
                          _selectedCard == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      method['icon'],
                      color: method['color'],
                      size: 40,
                    ),
                    title: Text(
                      method['type'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(method['number']),
                    trailing:
                        _selectedCard == index
                            ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                            : method['expiryDate'].isNotEmpty
                            ? Text('Exp: ${method['expiryDate']}')
                            : null,
                    onTap: () {
                      setState(() {
                        _selectedCard = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add new payment method logic
              },
              icon: const Icon(Icons.add),
              label: const Text('ADD PAYMENT METHOD'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = [
      {
        'date': 'May 22, 2023',
        'time': '10:30 AM',
        'items': [
          {'name': 'Cappuccino (Large)', 'quantity': 1},
          {'name': 'Croissant', 'quantity': 1},
        ],
        'total': 8.48,
        'status': 'Delivered',
        'statusColor': Colors.green,
      },
      {
        'date': 'May 19, 2023',
        'time': '3:45 PM',
        'items': [
          {'name': 'Mocha (Medium)', 'quantity': 2},
          {'name': 'Chocolate Muffin', 'quantity': 1},
        ],
        'total': 12.97,
        'status': 'Delivered',
        'statusColor': Colors.green,
      },
      {
        'date': 'May 15, 2023',
        'time': '9:15 AM',
        'items': [
          {'name': 'Espresso (Small)', 'quantity': 1},
        ],
        'total': 2.39,
        'status': 'Delivered',
        'statusColor': Colors.green,
      },
      {
        'date': 'May 10, 2023',
        'time': '2:20 PM',
        'items': [
          {'name': 'Cold Brew (Large)', 'quantity': 1},
          {'name': 'Cheese Danish', 'quantity': 1},
        ],
        'total': 9.48,
        'status': 'Delivered',
        'statusColor': Colors.green,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ORDER HISTORY',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body:
          orders.isEmpty
              ? const Center(
                child: Text('No orders yet', style: TextStyle(fontSize: 18)),
              )
              : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ExpansionTile(
                      title: Text(
                        'Order - ${order['date']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Row(
                        children: [
                          Text(order['time']),
                          const SizedBox(width: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: order['statusColor'].withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              order['status'],
                              style: TextStyle(
                                color: order['statusColor'],
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Items:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              ...List.generate(order['items'].length, (
                                itemIndex,
                              ) {
                                final item = order['items'][itemIndex];
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${item['quantity']}x ${item['name']}',
                                      ),
                                    ],
                                  ),
                                );
                              }),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Total:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '\$${order['total'].toStringAsFixed(2)}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('REORDER'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
    );
  }
}

class DeliveryAddressesPage extends StatefulWidget {
  const DeliveryAddressesPage({super.key});

  @override
  State<DeliveryAddressesPage> createState() => _DeliveryAddressesPageState();
}

class _DeliveryAddressesPageState extends State<DeliveryAddressesPage> {
  int _selectedAddress = 0;
  final List<Map<String, String>> _addresses = [
    {
      'name': 'Home',
      'address': '123 Coffee Street, Brew City, 54321',
      'instructions': 'Leave at the door',
    },
    {
      'name': 'Work',
      'address': '456 Java Avenue, Bean Town, 12345',
      'instructions': 'Reception desk',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'DELIVERY ADDRESSES',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color:
                          _selectedAddress == index
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      index == 0 ? Icons.home : Icons.work,
                      color: Theme.of(context).colorScheme.primary,
                      size: 30,
                    ),
                    title: Text(
                      address['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(address['address']!),
                        if (address['instructions']!.isNotEmpty)
                          Text(
                            'Note: ${address['instructions']}',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[600],
                            ),
                          ),
                      ],
                    ),
                    trailing:
                        _selectedAddress == index
                            ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).colorScheme.primary,
                            )
                            : Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                    onTap: () {
                      setState(() {
                        _selectedAddress = index;
                      });
                    },
                    isThreeLine: true,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add new address logic
              },
              icon: const Icon(Icons.add_location),
              label: const Text('ADD ADDRESS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _orderUpdates = true;
  bool _promotions = true;
  bool _recommendations = false;
  bool _appUpdates = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NOTIFICATIONS',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Order Updates'),
            subtitle: const Text('Notifications about your orders'),
            value: _orderUpdates,
            onChanged: (bool value) {
              setState(() {
                _orderUpdates = value;
              });
            },
            secondary: Icon(
              Icons.delivery_dining,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Promotions'),
            subtitle: const Text('Offers, discounts and sales'),
            value: _promotions,
            onChanged: (bool value) {
              setState(() {
                _promotions = value;
              });
            },
            secondary: Icon(
              Icons.discount,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Recommendations'),
            subtitle: const Text('Personalized coffee suggestions'),
            value: _recommendations,
            onChanged: (bool value) {
              setState(() {
                _recommendations = value;
              });
            },
            secondary: Icon(
              Icons.thumb_up,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('App Updates'),
            subtitle: const Text('Information about new features'),
            value: _appUpdates,
            onChanged: (bool value) {
              setState(() {
                _appUpdates = value;
              });
            },
            secondary: Icon(
              Icons.system_update,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notification settings saved'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('SAVE PREFERENCES'),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = false;
  bool _locationServices = true;
  String _language = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SETTINGS',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            title: const Text('Account Settings'),
            leading: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable dark theme'),
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
            },
            secondary: Icon(
              Icons.dark_mode,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Location Services'),
            subtitle: const Text('Allow app to access your location'),
            value: _locationServices,
            onChanged: (bool value) {
              setState(() {
                _locationServices = value;
              });
            },
            secondary: Icon(
              Icons.location_on,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Language'),
            subtitle: Text(_language),
            leading: Icon(
              Icons.language,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          title: const Text('English'),
                          trailing:
                              _language == 'English'
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                          onTap: () {
                            setState(() {
                              _language = 'English';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Spanish'),
                          trailing:
                              _language == 'Spanish'
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                          onTap: () {
                            setState(() {
                              _language = 'Spanish';
                            });
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('French'),
                          trailing:
                              _language == 'French'
                                  ? const Icon(Icons.check, color: Colors.green)
                                  : null,
                          onTap: () {
                            setState(() {
                              _language = 'French';
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: Icon(
              Icons.security,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('Terms of Service'),
            leading: Icon(
              Icons.description,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            title: const Text('About'),
            leading: Icon(
              Icons.info,
              color: Theme.of(context).colorScheme.primary,
            ),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'Coffee Haven',
                applicationVersion: '1.0.0',
                applicationIcon: Icon(
                  Icons.coffee,
                  color: Theme.of(context).colorScheme.primary,
                  size: 50,
                ),
                children: [
                  const Text(
                    'Coffee Haven is your go-to app for ordering delicious coffee drinks and pastries.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// Coffee data
final List<Coffee> hotCoffees = [
  Coffee(
    name: 'Espresso',
    price: 2.99,
    image: 'https://images.unsplash.com/photo-1520031607889-97ba0c7190ff?w=500',
    description: 'Strong and rich Italian coffee',
    icon: Icons.coffee,
  ),
  Coffee(
    name: 'Cappuccino',
    price: 3.99,
    image: 'https://images.unsplash.com/photo-1534778101976-62847782c213?w=500',
    description: 'Classic Italian coffee with steamed milk',
    icon: Icons.coffee_maker,
  ),
  Coffee(
    name: 'Americano',
    price: 3.49,
    image: 'https://images.unsplash.com/photo-1559496417-e7f25cb247f3?w=500',
    description: 'Espresso with added hot water',
    icon: Icons.coffee,
  ),
];

final List<Coffee> coldCoffees = [
  Coffee(
    name: 'Iced Latte',
    price: 4.49,
    image: 'https://images.unsplash.com/photo-1553909489-cd47e0907980?w=500',
    description: 'Chilled espresso with cold milk',
    icon: Icons.ac_unit,
  ),
  Coffee(
    name: 'Cold Brew',
    price: 4.99,
    image: 'https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500',
    description: 'Coffee brewed with cold water for 12+ hours',
    icon: Icons.local_drink,
  ),
];

class Coffee {
  final String name;
  final double price;
  final String image;
  final String description;
  final IconData icon;

  Coffee({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.icon,
  });
}
