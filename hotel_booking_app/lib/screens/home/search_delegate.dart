import 'package:flutter/material.dart';

class HotelSearchDelegate extends SearchDelegate<String> {
  final List<String> _hotels = [
    'Sheraton Addis',
    'Hilton Addis Ababa',
    'Radisson Blu',
    'Skylight Hotel',
    'Intercontinental Addis',
    'Ghion Hotel',
    'Jupiter Hotel',
    'Harmony Hotel',
    'Capital Hotel',
    'Bole Ambassador',
  ];

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
        ? _hotels
        : _hotels.where((hotel) => hotel.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.hotel, color: Color(0xFF0A1F3A)),
        title: Text(results[index]),
        subtitle: Text('Tap to search for this hotel'),
        onTap: () {
          close(context, results[index]);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Searching for ${results[index]}...'),
              backgroundColor: const Color(0xFF0A1F3A),
            ),
          );
        },
      ),
    );
  }
}