import 'package:flutter/material.dart';
import '../../utils/routes.dart';
import 'pages/map_page.dart';
import 'pages/explore_page.dart';
import 'pages/bookings_page.dart';
import 'pages/profile_page.dart';
import 'search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Navigation
  int _currentIndex = 0;
  
  // Filter states (only for map page)
  bool _showFilters = false;
  double _price = 1000;
  double _distance = 10;
  String _hotelType = 'All';

  final List<String> _hotelTypes = ['All', 'Budget', 'Mid-range', 'Luxury', 'Boutique'];

  // Pages for navigation
  final List<Widget> _pages = [
    const MapPage(),
    const ExplorePage(),
    const BookingsPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: const Text(
          'EthioStay',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: _showSearch,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Current Page
          _pages[_currentIndex],
          
          // Filter-specific widgets (only on Map page)
          if (_currentIndex == 0) ...[
            // Current Filters (Top)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: _buildCurrentFilters(),
            ),

            // My Location Button
            Positioned(
              bottom: 100,
              right: 20,
              child: FloatingActionButton.small(
                onPressed: _goToMyLocation,
                backgroundColor: Colors.white,
                child: const Icon(Icons.my_location, color: Color(0xFF0A1F3A)),
              ),
            ),

            // Filters Panel
            if (_showFilters) _buildFiltersPanel(),
          ],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF0A1F3A),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0 
          ? FloatingActionButton(
              onPressed: () => setState(() => _showFilters = !_showFilters),
              backgroundColor: const Color(0xFF0A1F3A),
              child: Icon(_showFilters ? Icons.close : Icons.filter_list),
            )
          : null,
      drawer: _buildDrawer(),
    );
  }

  Widget _buildCurrentFilters() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.filter_list, size: 20, color: Color(0xFF0A1F3A)),
          const SizedBox(width: 10),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('ETB ${_price.toInt()}'),
                  const SizedBox(width: 8),
                  _buildFilterChip('${_distance.toInt()} km'),
                  const SizedBox(width: 8),
                  _buildFilterChip(_hotelType),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, size: 24),
            onPressed: () => setState(() => _showFilters = true),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1F3A).withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12, color: Color(0xFF0A1F3A))),
    );
  }

  Widget _buildFiltersPanel() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 400,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 20)],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Filters', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_down),
                        onPressed: () => setState(() => _showFilters = false),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildFilterItem(
                      title: 'Price Range: ETB ${_price.toInt()}',
                      child: Slider(
                        value: _price,
                        min: 100,
                        max: 5000,
                        onChanged: (value) => setState(() => _price = value),
                        activeColor: const Color(0xFF0A1F3A),
                      ),
                      minLabel: 'ETB 100',
                      maxLabel: 'ETB 5000',
                    ),
                    const SizedBox(height: 25),
                    _buildFilterItem(
                      title: 'Distance: ${_distance.toInt()} km',
                      child: Slider(
                        value: _distance,
                        min: 1,
                        max: 50,
                        onChanged: (value) => setState(() => _distance = value),
                        activeColor: const Color(0xFF0A1F3A),
                      ),
                      minLabel: '1 km',
                      maxLabel: '50 km',
                    ),
                    const SizedBox(height: 25),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hotel Type', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _hotelTypes.map((type) {
                            return ChoiceChip(
                              label: Text(type),
                              selected: _hotelType == type,
                              onSelected: (_) => setState(() => _hotelType = type),
                              selectedColor: const Color(0xFF0A1F3A),
                              labelStyle: TextStyle(
                                color: _hotelType == type ? Colors.white : Colors.black,
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() => _showFilters = false);
                          _showMessage('Filters applied: ETB ${_price.toInt()}, ${_distance.toInt()}km, $_hotelType');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0A1F3A),
                        ),
                        child: const Text('Apply Filters', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterItem({
    required String title,
    required Widget child,
    required String minLabel,
    required String maxLabel,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        child,
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(minLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            Text(maxLabel, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 200,
            color: const Color(0xFF0A1F3A),
            padding: const EdgeInsets.only(top: 50),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50, color: Color(0xFF0A1F3A)),
                ),
                SizedBox(height: 15),
                Text('John Doe', style: TextStyle(color: Colors.white, fontSize: 18)),
                SizedBox(height: 5),
                Text('user@example.com', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(Icons.home, 'Home', () => Navigator.pop(context)),
                _drawerItem(Icons.person, 'Profile', () {}),
                _drawerItem(Icons.bookmark, 'Bookings', () {}),
                _drawerItem(Icons.favorite, 'Favorites', () {}),
                _drawerItem(Icons.settings, 'Settings', () {}),
                const Divider(),
                _drawerItem(Icons.logout, 'Logout', () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }, color: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      onTap: onTap,
    );
  }

  // Actions
  void _showSearch() {
    showSearch(
      context: context,
      delegate: HotelSearchDelegate(),
    );
  }

  void _goToMyLocation() {
    _showMessage('Navigating to your location...');
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      ),
    );
  }
}