import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  // Search and filter states
  String _searchQuery = '';
  String _selectedCategory = 'Recommended';
  final List<String> _categories = [
    'Recommended',
    'Hotels',
    'Restaurants',
    'Pensions',
    'Guest Houses',
    'Resorts',
    'Apartments',
  ];

  // Sample data
  final List<Map<String, dynamic>> _allPlaces = [
    {
      'name': 'Sheraton Addis',
      'type': 'Hotel',
      'category': 'Hotels',
      'price': 'ETB 8,500',
      'rating': 4.8,
      'description': 'Luxury 5-star hotel in city center',
      'isRecommended': true,
    },
    {
      'name': 'Kategna Restaurant',
      'type': 'Restaurant',
      'category': 'Restaurants',
      'price': 'ETB 500-1,500',
      'rating': 4.5,
      'description': 'Traditional Ethiopian cuisine',
      'isRecommended': true,
    },
    {
      'name': 'Bole Pension',
      'type': 'Pension',
      'category': 'Pensions',
      'price': 'ETB 1,200',
      'rating': 4.2,
      'description': 'Budget friendly accommodation',
      'isRecommended': false,
    },
    {
      'name': 'Hilton Addis Ababa',
      'type': 'Hotel',
      'category': 'Hotels',
      'price': 'ETB 6,200',
      'rating': 4.6,
      'description': 'Business hotel with conference facilities',
      'isRecommended': true,
    },
    {
      'name': 'Yod Abyssinia',
      'type': 'Restaurant',
      'category': 'Restaurants',
      'price': 'ETB 400-1,200',
      'rating': 4.7,
      'description': 'Cultural restaurant with live music',
      'isRecommended': true,
    },
    {
      'name': 'City Pension',
      'type': 'Pension',
      'category': 'Pensions',
      'price': 'ETB 900',
      'rating': 4.0,
      'description': 'Clean and affordable rooms',
      'isRecommended': false,
    },
    {
      'name': 'Radisson Blu',
      'type': 'Hotel',
      'category': 'Hotels',
      'price': 'ETB 5,800',
      'rating': 4.5,
      'description': 'Modern hotel with great views',
      'isRecommended': false,
    },
    {
      'name': 'Habesha 2000',
      'type': 'Restaurant',
      'category': 'Restaurants',
      'price': 'ETB 300-800',
      'rating': 4.3,
      'description': 'Local Ethiopian dishes',
      'isRecommended': false,
    },
  ];

  // Get filtered places based on search and category
  List<Map<String, dynamic>> get _filteredPlaces {
    List<Map<String, dynamic>> filtered = _allPlaces;

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((place) {
        return place['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
               place['description'].toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    }

    // Filter by category
    if (_selectedCategory != 'Recommended') {
      filtered = filtered.where((place) {
        return place['category'] == _selectedCategory;
      }).toList();
    } else {
      // For Recommended, show places marked as recommended
      filtered = filtered.where((place) {
        return place['isRecommended'] == true;
      }).toList();
    }

    // Sort by rating (highest first)
    filtered.sort((a, b) => b['rating'].compareTo(a['rating']));

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Search and Filter Bar
          _buildSearchBar(),
          
          // Category Filter Chips
          _buildCategoryFilter(),
          
          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  '${_filteredPlaces.length} places found',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const Spacer(),
                Text(
                  'Sorted by: Rating',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          // Places List
          Expanded(
            child: _filteredPlaces.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: _filteredPlaces.length,
                    itemBuilder: (context, index) {
                      return _buildPlaceCard(_filteredPlaces[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore Places',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0A1F3A),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Discover amazing places to stay and eat',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              hintText: 'Search places, hotels, restaurants...',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    )
                  : null,
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          const SizedBox(width: 20),
          const Text(
            'Category:',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categories.map((category) {
                final bool isSelected = _selectedCategory == category;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = category;
                      });
                    },
                    selectedColor: const Color(0xFF0A1F3A),
                    backgroundColor: Colors.grey[200],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildPlaceCard(Map<String, dynamic> place) {
    IconData icon;
    Color iconColor;
    
    switch (place['type']) {
      case 'Hotel':
        icon = Icons.hotel;
        iconColor = Colors.blue;
        break;
      case 'Restaurant':
        icon = Icons.restaurant;
        iconColor = Colors.green;
        break;
      case 'Pension':
        icon = Icons.home;
        iconColor = Colors.orange;
        break;
      default:
        icon = Icons.place;
        iconColor = Colors.purple;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: iconColor, size: 30),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    place['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (place['isRecommended'])
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.star, size: 12, color: Colors.amber),
                        SizedBox(width: 4),
                        Text(
                          'Recommended',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.amber,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              place['description'],
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(
                  place['rating'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A1F3A).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    place['type'],
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF0A1F3A),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              place['price'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF0A1F3A),
              ),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // Handle booking/visiting
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A1F3A),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                minimumSize: const Size(80, 30),
              ),
              child: const Text(
                'View',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          const Text(
            'No places found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Try a different search or category',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _searchQuery = '';
                _selectedCategory = 'Recommended';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0A1F3A),
            ),
            child: const Text('Clear Filters'),
          ),
        ],
      ),
    );
  }
}