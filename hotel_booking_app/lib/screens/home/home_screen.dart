import 'package:flutter/material.dart';
import '../../utils/routes.dart';
import 'pages/map_page.dart';
import 'pages/explore_page.dart';
import 'pages/bookings_page.dart';
import 'pages/profile_tab_page.dart';
import 'search_delegate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  
  // Filter states
  bool _showFilters = false;
  double _price = 1000;
  double _distance = 10;
  String _hotelType = 'All';

  final List<Widget> _pages = [
    // Map page will be added dynamically
    Container(), // Placeholder
    const ExplorePage(),
    const BookingsPage(),
    ProfileTabPage(), // NO 'const' keyword
  ];

  @override
  Widget build(BuildContext context) {
    // Update map page with current state
    _pages[0] = MapPage(
      onMapTap: _hideFilters,
      showFilters: _showFilters,
      onFilterToggle: _toggleFilters,
      price: _price,
      distance: _distance,
      hotelType: _hotelType,
      onPriceChanged: (value) => setState(() => _price = value),
      onDistanceChanged: (value) => setState(() => _distance = value),
      onHotelTypeChanged: (value) => setState(() => _hotelType = value),
      onApplyFilters: _applyFilters,
      onResetFilters: _resetFilters,
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
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
          
          // Current Filters Bar (Top) - Only on Map page
          if (_currentIndex == 0)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: _buildCurrentFilters(),
            ),

          // My Location Button - Only on Map page (no FAB to avoid hero conflict)
          if (_currentIndex == 0)
            Positioned(
              bottom: 100,
              right: 20,
              child: Material(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
                elevation: 3,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: _goToMyLocation,
                  child: Container(
                    width: 40,
                    height: 40,
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.my_location, color: Color(0xFF0A1F3A)),
                  ),
                ),
              ),
            ),
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
          ? Container(
              margin: EdgeInsets.only(bottom: 70),
              child: FloatingActionButton(
                onPressed: _toggleFilters,
                backgroundColor: const Color(0xFF0A1F3A),
                child: Icon(_showFilters ? Icons.close : Icons.filter_list),
              ),
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

  Widget _buildDrawer() {
    return Drawer(
      child: SingleChildScrollView(
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
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                _drawerItem(Icons.home, 'Home', () => Navigator.pop(context)),
                _drawerItem(Icons.person, 'Profile', () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 3;
                  });
                }),
                _drawerItem(Icons.bookmark, 'Bookings', () {
                  Navigator.pop(context);
                  setState(() {
                    _currentIndex = 2;
                  });
                }),
                _drawerItem(Icons.favorite, 'Favorites', () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.favorites);
                }),
                _drawerItem(Icons.settings, 'Settings', () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.settings);
                }),
                const Divider(),
                _drawerItem(Icons.logout, 'Logout', () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                }, color: Colors.red),
              ],
            ),
          ],
        ),
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

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  void _hideFilters() {
    if (_showFilters) {
      setState(() {
        _showFilters = false;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _showFilters = false;
    });
    _showMessage('Filters applied: ETB ${_price.toInt()}, ${_distance.toInt()}km, $_hotelType');
  }

  void _resetFilters() {
    setState(() {
      _price = 1000;
      _distance = 10;
      _hotelType = 'All';
    });
    _showMessage('All filters have been reset');
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