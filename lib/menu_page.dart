import 'package:flutter/material.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = [
    "Espresso",
    "Latte",
    "Cappuccino",
    "Cold Brew",
    "Pastries",
  ];

  final Map<String, List<MenuItem>> _menuItems = {
    "Espresso": [
      MenuItem(
        name: "Single Espresso",
        price: 2.99,
        image:
            "https://images.unsplash.com/photo-1520031607889-97ba0c7190ff?w=500",
        description: "Strong and rich Italian coffee",
        isFavorite: false,
      ),
      MenuItem(
        name: "Double Espresso",
        price: 3.99,
        image:
            "https://images.unsplash.com/photo-1591522810850-58128c5fb089?w=500",
        description: "Double shot of intense espresso",
        isFavorite: false,
      ),
      MenuItem(
        name: "Espresso Macchiato",
        price: 3.49,
        image:
            "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500", // Remplacé l'image qui retournait 404
        description: "Espresso with a dash of frothy milk",
        isFavorite: true,
      ),
    ],
    "Latte": [
      MenuItem(
        name: "Classic Latte",
        price: 4.29,
        image:
            "https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500",
        description: "Espresso with steamed milk and a light layer of foam",
        isFavorite: false,
      ),
      MenuItem(
        name: "Vanilla Latte",
        price: 4.99,
        image:
            "https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500",
        description: "Espresso with vanilla syrup and steamed milk",
        isFavorite: true,
      ),
      MenuItem(
        name: "Caramel Latte",
        price: 4.99,
        image:
            "https://images.unsplash.com/photo-1594631252845-29fc4cc8cde9?w=500",
        description: "Espresso with caramel syrup and steamed milk",
        isFavorite: false,
      ),
    ],
    "Cappuccino": [
      MenuItem(
        name: "Classic Cappuccino",
        price: 3.99,
        image:
            "https://images.unsplash.com/photo-1534778101976-62847782c213?w=500",
        description: "Equal parts espresso, steamed milk, and foam",
        isFavorite: false,
      ),
      MenuItem(
        name: "Cinnamon Cappuccino",
        price: 4.49,
        image:
            "https://images.unsplash.com/photo-1577968897966-3d4325b36b61?w=500",
        description: "Cappuccino with cinnamon sprinkled on top",
        isFavorite: false,
      ),
    ],
    "Cold Brew": [
      MenuItem(
        name: "Classic Cold Brew",
        price: 3.99,
        image:
            "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
        description: "Coffee brewed with cold water for 12+ hours",
        isFavorite: false,
      ),
      MenuItem(
        name: "Vanilla Sweet Cream Cold Brew",
        price: 4.99,
        image:
            "https://images.unsplash.com/photo-1461023058943-07fcbe16d735?w=500",
        description: "Cold brew topped with vanilla sweet cream",
        isFavorite: false,
      ),
    ],
    "Pastries": [
      MenuItem(
        name: "Croissant",
        price: 2.99,
        image:
            "https://images.unsplash.com/photo-1549903072-7e6e0bedb7fb?w=500",
        description: "Buttery, flaky pastry",
        isFavorite: false,
      ),
      MenuItem(
        name: "Chocolate Chip Cookie",
        price: 2.49,
        image:
            "https://images.unsplash.com/photo-1499636136210-6f4ee915583e?w=500",
        description: "Classic chocolate chip cookie",
        isFavorite: false,
      ),
      MenuItem(
        name: "Blueberry Muffin",
        price: 3.49,
        image:
            "https://images.unsplash.com/photo-1587668178277-295251f900ce?w=500", // Remplacé l'image qui retournait 404
        description: "Moist muffin loaded with blueberries",
        isFavorite: false,
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OUR MENU',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () {}),
          IconButton(icon: const Icon(Icons.filter_list), onPressed: () {}),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: _categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:
            _categories.map((category) {
              return _buildCategoryItems(category);
            }).toList(),
      ),
    );
  }

  Widget _buildCategoryItems(String category) {
    final items = _menuItems[category] ?? [];

    return items.isEmpty
        ? const Center(child: Text("No items available"))
        : ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildMenuItem(items[index]);
          },
        );
  }

  Widget _buildMenuItem(MenuItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                item.image,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
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
                      Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          item.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: item.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            item.isFavorite = !item.isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    item.description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart, size: 16),
                        label: const Text("Add to Cart"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem {
  final String name;
  final double price;
  final String image;
  final String description;
  bool isFavorite;

  MenuItem({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.isFavorite = false,
  });
}
