import 'package:flutter/material.dart';
import 'favorites_page.dart';
import 'menu_page.dart';
import 'profile_page.dart';
import 'cart_page.dart';
import 'order_form.dart'; // Import the order form page

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
          'https://images.unsplash.com/photo-1495231916356-a86217efff12?w=500',
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
          'https://images.unsplash.com/photo-1579888944880-d98341245702?w=500',
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
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartPage()),
              );
            },
          ),
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
                    // ignore: deprecated_member_use
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
                              // Create a default set of items for quick ordering
                              final List<CartItem> quickOrderItems = [
                                CartItem(
                                  name: "House Blend Coffee",
                                  price: 3.49,
                                  image:
                                      "https://images.unsplash.com/photo-1495231916356-a86217efff12?w=500",
                                  quantity: 1,
                                  options: "Medium, Regular",
                                ),
                              ];

                              // Calculate default totals
                              double subtotal = 3.49; // Cost of the house blend
                              double tax = subtotal * 0.08;
                              double deliveryFee = 2.50;
                              double total = subtotal + tax + deliveryFee;

                              // Navigate to the order form
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => OrderFormPage(
                                        cartItems: quickOrderItems,
                                        subtotal: subtotal,
                                        tax: tax,
                                        deliveryFee: deliveryFee,
                                        total: total,
                                      ),
                                ),
                              );
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {},
        tooltip: 'Quick Order',
        child: const Icon(Icons.add, color: Colors.white),
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
              // ignore: deprecated_member_use
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
