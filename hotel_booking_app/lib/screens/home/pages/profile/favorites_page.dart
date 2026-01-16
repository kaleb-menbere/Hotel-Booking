import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  String _selectedCategory = 'All';
  final List<String> _categories = ['All', 'Hotels', 'Restaurants', 'Pensions'];

  final List<Map<String, dynamic>> _favorites = [
    {
      'id': '1',
      'name': 'Sheraton Addis',
      'type': 'Hotel',
      'category': 'Hotels',
      'price': 8500,
      'rating': 4.8,
      'location': 'Bole, Addis Ababa',
      'image': 'hotel1',
      'isFavorite': true,
    },
    {
      'id': '2',
      'name': 'Kategna Restaurant',
      'type': 'Restaurant',
      'category': 'Restaurants',
      'price': 800,
      'rating': 4.5,
      'location': 'Bole, Addis Ababa',
      'image': 'rest1',
      'isFavorite': true,
    },
    {
      'id': '3',
      'name': 'Hilton Addis Ababa',
      'type': 'Hotel',
      'category': 'Hotels',
      'price': 6200,
      'rating': 4.6,
      'location': 'Menelik II Ave',
      'image': 'hotel2',
      'isFavorite': true,
    },
    {
      'id': '4',
      'name': 'Bole Pension',
      'type': 'Pension',
      'category': 'Pensions',
      'price': 1200,
      'rating': 4.2,
      'location': 'Bole, Addis Ababa',
      'image': 'pension1',
      'isFavorite': true,
    },
    {
      'id': '5',
      'name': 'Yod Abyssinia',
      'type': 'Restaurant',
      'category': 'Restaurants',
      'price': 600,
      'rating': 4.7,
      'location': 'Bole, Addis Ababa',
      'image': 'rest2',
      'isFavorite': true,
    },
  ];

  List<Map<String, dynamic>> get _filteredFavorites {
    if (_selectedCategory == 'All') return _favorites;
    return _favorites.where((item) => item['category'] == _selectedCategory).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _searchFavorites,
          ),
        ],
      ),
      body: Column(
        children: [
          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text('$category (${_getCountByCategory(category)})'),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => _selectedCategory = category),
                    selectedColor: const Color(0xFF0A1F3A),
                    labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                  ),
                );
              },
            ),
          ),
          
          // Favorites List
          Expanded(
            child: _filteredFavorites.isEmpty
                ? _buildEmptyState()
                : GridView.builder(
                    padding: const EdgeInsets.all(20),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: _filteredFavorites.length,
                    itemBuilder: (context, index) {
                      return _buildFavoriteCard(_filteredFavorites[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(Map<String, dynamic> favorite) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image placeholder
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: _getColorByType(favorite['type']),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                ),
                child: Center(
                  child: Icon(
                    _getIconByType(favorite['type']),
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      favorite['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      favorite['location'],
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 14),
                        const SizedBox(width: 4),
                        Text(favorite['rating'].toString()),
                        const Spacer(),
                        Text(
                          'ETB ${favorite['price']}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0A1F3A)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Favorite button
          Positioned(
            top: 5,
            right: 5,
            child: IconButton(
              icon: Icon(
                favorite['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                color: Colors.red,
              ),
              onPressed: () => _toggleFavorite(favorite['id']),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.favorite_border, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          const Text(
            'No favorites yet',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          const Text(
            'Save your favorite places to see them here',
            style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _browsePlaces,
            icon: const Icon(Icons.explore),
            label: const Text('Browse Places'),
          ),
        ],
      ),
    );
  }

  int _getCountByCategory(String category) {
    if (category == 'All') return _favorites.length;
    return _favorites.where((item) => item['category'] == category).length;
  }

  Color _getColorByType(String type) {
    switch (type) {
      case 'Hotel':
        return Colors.blue;
      case 'Restaurant':
        return Colors.green;
      case 'Pension':
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }

  IconData _getIconByType(String type) {
    switch (type) {
      case 'Hotel':
        return Icons.hotel;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Pension':
        return Icons.home;
      default:
        return Icons.place;
    }
  }

  void _toggleFavorite(String id) {
    setState(() {
      final favorite = _favorites.firstWhere((item) => item['id'] == id);
      favorite['isFavorite'] = !favorite['isFavorite'];
      
      if (!favorite['isFavorite']) {
        _favorites.removeWhere((item) => item['id'] == id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Removed ${favorite['name']} from favorites')),
        );
      }
    });
  }

  void _searchFavorites() {
    showSearch(
      context: context,
      delegate: _FavoriteSearchDelegate(_favorites),
    );
  }

  void _browsePlaces() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Redirecting to explore page...')),
    );
  }
}

class _FavoriteSearchDelegate extends SearchDelegate<String> {
  final List<Map<String, dynamic>> _favorites;

  _FavoriteSearchDelegate(this._favorites);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, ''),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = query.isEmpty
        ? _favorites
        : _favorites.where((item) => item['name'].toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return ListTile(
          leading: Icon(_getIconByType(item['type']), color: const Color(0xFF0A1F3A)),
          title: Text(item['name']),
          subtitle: Text('${item['type']} • ETB ${item['price']}'),
          trailing: IconButton(
            icon: Icon(Icons.favorite, color: Colors.red),
            onPressed: () {},
          ),
        );
      },
    );
  }

  IconData _getIconByType(String type) {
    switch (type) {
      case 'Hotel':
        return Icons.hotel;
      case 'Restaurant':
        return Icons.restaurant;
      case 'Pension':
        return Icons.home;
      default:
        return Icons.place;
    }
  }
}