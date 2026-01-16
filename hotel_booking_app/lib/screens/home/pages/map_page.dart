import 'package:flutter/material.dart';

class MapPage extends StatefulWidget {
  final VoidCallback? onMapTap;
  final bool showFilters;
  final VoidCallback? onFilterToggle;
  final double price;
  final double distance;
  final String hotelType;
  final Function(double) onPriceChanged;
  final Function(double) onDistanceChanged;
  final Function(String) onHotelTypeChanged;
  final VoidCallback? onApplyFilters;
  final VoidCallback? onResetFilters;

  const MapPage({
    Key? key,
    this.onMapTap,
    this.showFilters = false,
    this.onFilterToggle,
    this.price = 1000,
    this.distance = 10,
    this.hotelType = 'All',
    required this.onPriceChanged,
    required this.onDistanceChanged,
    required this.onHotelTypeChanged,
    this.onApplyFilters,
    this.onResetFilters,
  }) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final List<String> _hotelTypes = ['All', 'Budget', 'Mid-range', 'Luxury', 'Boutique'];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Clickable Map Area
        GestureDetector(
          onTap: widget.onMapTap,
          child: Container(
            color: Colors.grey[100],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text('Map View', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Text('Tap map to close filters'),
                  SizedBox(height: 5),
                  Text('Use filters to refine your search'),
                ],
              ),
            ),
          ),
        ),

        // Filters Panel
        if (widget.showFilters) _buildFiltersPanel(),
      ],
    );
  }

  Widget _buildFiltersPanel() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 420, // Reduced height
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Column(
          children: [
            // Drag handle and header
            GestureDetector(
              onTap: widget.onFilterToggle,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Drag handle
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
                        const Text(
                          'Filter Settings',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0A1F3A),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_down, size: 28),
                          onPressed: widget.onFilterToggle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Filters Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Price Range Filter
                    _buildFilterSection(
                      title: 'Price Range',
                      currentValue: 'ETB ${widget.price.toInt()}',
                      minLabel: 'ETB 100',
                      maxLabel: 'ETB 5000',
                      child: Slider(
                        value: widget.price,
                        min: 100,
                        max: 5000,
                        divisions: 49,
                        label: 'ETB ${widget.price.toInt()}',
                        onChanged: widget.onPriceChanged,
                        activeColor: const Color(0xFF0A1F3A),
                        inactiveColor: Colors.grey[300],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Distance Filter
                    _buildFilterSection(
                      title: 'Distance from you',
                      currentValue: '${widget.distance.toInt()} km',
                      minLabel: '1 km',
                      maxLabel: '50 km',
                      child: Slider(
                        value: widget.distance,
                        min: 1,
                        max: 50,
                        divisions: 49,
                        label: '${widget.distance.toInt()} km',
                        onChanged: widget.onDistanceChanged,
                        activeColor: const Color(0xFF0A1F3A),
                        inactiveColor: Colors.grey[300],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Hotel Type Filter
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Hotel Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _hotelTypes.map((type) {
                            return FilterChip(
                              label: Text(type),
                              selected: widget.hotelType == type,
                              onSelected: (selected) {
                                widget.onHotelTypeChanged(type);
                              },
                              backgroundColor: Colors.grey[200],
                              selectedColor: const Color(0xFF0A1F3A),
                              labelStyle: TextStyle(
                                color: widget.hotelType == type ? Colors.white : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 40),

                    // Apply & Reset Buttons
                    Row(
                      children: [
                        // Reset Button
                        Expanded(
                          child: OutlinedButton(
                            onPressed: widget.onResetFilters,
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF0A1F3A)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Reset All',
                              style: TextStyle(
                                color: Color(0xFF0A1F3A),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        // Apply Button
                        Expanded(
                          child: ElevatedButton(
                            onPressed: widget.onApplyFilters,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0A1F3A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: const Text(
                              'Apply Filters',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  Widget _buildFilterSection({
    required String title,
    required String currentValue,
    required String minLabel,
    required String maxLabel,
    required Widget child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            Text(
              currentValue,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0A1F3A),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        child,
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              minLabel,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              maxLabel,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}