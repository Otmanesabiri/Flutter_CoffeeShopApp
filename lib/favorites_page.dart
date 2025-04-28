import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final List<FavoriteCoffee> _favorites = [
    FavoriteCoffee(
      name: "Caramel Macchiato",
      price: 4.99,
      image:
          "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?w=500",
      description:
          "Espresso with vanilla-flavored syrup, milk and caramel sauce",
      isFavorite: true,
    ),
    FavoriteCoffee(
      name: "Vanilla Latte",
      price: 4.49,
      image:
          "https://images.unsplash.com/photo-1517701550927-30cf4ba1dba5?w=500",
      description: "Espresso with vanilla syrup and steamed milk",
      isFavorite: true,
    ),
    FavoriteCoffee(
      name: "Mocha",
      price: 4.99,
      image:
          "https://images.unsplash.com/photo-1579888944880-d98341245702?w=500",
      description: "Espresso with chocolate and steamed milk",
      isFavorite: true,
    ),
    FavoriteCoffee(
      name: "Cold Brew",
      price: 3.99,
      image:
          "https://images.unsplash.com/photo-1517701604599-bb29b565090c?w=500",
      description: "Coffee brewed with cold water for 12+ hours",
      isFavorite: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MY FAVORITES',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),
      body:
          _favorites.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _favorites.length,
                itemBuilder: (context, index) {
                  return _buildFavoriteItem(_favorites[index]);
                },
              ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            "No favorites yet",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start adding some coffee to your favorites",
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text("Browse Menu"),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteItem(FavoriteCoffee coffee) {
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
                coffee.image,
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
                        coffee.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          coffee.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: coffee.isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            coffee.isFavorite = !coffee.isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    coffee.description,
                    style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${coffee.price.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_shopping_cart, size: 16),
                        label: const Text("Order Again"),
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

class FavoriteCoffee {
  final String name;
  final double price;
  final String image;
  final String description;
  bool isFavorite;

  FavoriteCoffee({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    this.isFavorite = false,
  });
}
