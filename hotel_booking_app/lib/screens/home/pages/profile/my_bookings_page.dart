import 'package:flutter/material.dart';

class MyBookingsPage extends StatefulWidget {
  const MyBookingsPage({Key? key}) : super(key: key);

  @override
  State<MyBookingsPage> createState() => _MyBookingsPageState();
}

class _MyBookingsPageState extends State<MyBookingsPage> {
  String _selectedFilter = 'Upcoming';
  final List<String> _filters = ['All', 'Upcoming', 'Completed', 'Cancelled'];

  final List<Map<String, dynamic>> _allBookings = [
    {
      'id': 'ETH2345',
      'hotel': 'Sheraton Addis',
      'date': 'Jan 15-20, 2024',
      'nights': 5,
      'guests': 2,
      'amount': 42500,
      'status': 'Confirmed',
      'type': 'Hotel',
      'room': 'Deluxe King',
    },
    {
      'id': 'ETH1892',
      'hotel': 'Kategna Restaurant',
      'date': 'Dec 10, 2023',
      'nights': 1,
      'guests': 4,
      'amount': 3200,
      'status': 'Completed',
      'type': 'Restaurant',
      'room': 'Table for 4',
    },
    {
      'id': 'ETH2678',
      'hotel': 'Radisson Blu',
      'date': 'Feb 5-8, 2024',
      'nights': 3,
      'guests': 2,
      'amount': 17400,
      'status': 'Upcoming',
      'type': 'Hotel',
      'room': 'Standard Double',
    },
    {
      'id': 'ETH1567',
      'hotel': 'Jupiter Hotel',
      'date': 'Nov 20-22, 2023',
      'nights': 2,
      'guests': 1,
      'amount': 3600,
      'status': 'Cancelled',
      'type': 'Hotel',
      'room': 'Single Room',
    },
    {
      'id': 'ETH2890',
      'hotel': 'Yod Abyssinia',
      'date': 'Jan 25, 2024',
      'nights': 1,
      'guests': 6,
      'amount': 5400,
      'status': 'Completed',
      'type': 'Restaurant',
      'room': 'VIP Section',
    },
  ];

  List<Map<String, dynamic>> get _filteredBookings {
    if (_selectedFilter == 'All') return _allBookings;
    return _allBookings.where((booking) => booking['status'] == _selectedFilter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: Column(
        children: [
          // Filter Chips
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (selected) => setState(() => _selectedFilter = filter),
                    selectedColor: const Color(0xFF0A1F3A),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Booking Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  '${_filteredBookings.length} bookings found',
                  style: const TextStyle(color: Colors.grey),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _showAdvancedFilters,
                ),
              ],
            ),
          ),
          
          // Bookings List
          Expanded(
            child: _filteredBookings.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: _filteredBookings.length,
                    itemBuilder: (context, index) {
                      return _buildBookingCard(_filteredBookings[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(Map<String, dynamic> booking) {
    Color statusColor;
    switch (booking['status']) {
      case 'Confirmed':
        statusColor = Colors.green;
        break;
      case 'Completed':
        statusColor = Colors.blue;
        break;
      case 'Upcoming':
        statusColor = Colors.orange;
        break;
      case 'Cancelled':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  booking['type'] == 'Hotel' ? Icons.hotel : Icons.restaurant,
                  color: const Color(0xFF0A1F3A),
                  size: 30,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking['hotel'],
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Booking #${booking['id']}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    booking['status'],
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildDetailItem(Icons.calendar_today, booking['date']),
                _buildDetailItem(Icons.bed, '${booking['nights']} nights'),
                _buildDetailItem(Icons.people, '${booking['guests']} guests'),
                _buildDetailItem(Icons.meeting_room, booking['room']),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ETB ${booking['amount'].toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A1F3A)),
                ),
                Row(
                  children: [
                    if (booking['status'] == 'Upcoming' || booking['status'] == 'Confirmed')
                      OutlinedButton(
                        onPressed: () => _cancelBooking(booking['id']),
                        child: const Text('Cancel'),
                      ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => _viewBookingDetails(booking['id']),
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0A1F3A)),
                      child: const Text('View Details'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(height: 5),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
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
          Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 20),
          const Text(
            'No bookings found',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 10),
          Text(
            _selectedFilter == 'All'
                ? 'You haven\'t made any bookings yet'
                : 'No ${_selectedFilter.toLowerCase()} bookings',
            style: TextStyle(fontSize: 16, color: Colors.grey[500]),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => setState(() => _selectedFilter = 'All'),
            child: const Text('View All Bookings'),
          ),
        ],
      ),
    );
  }

  void _showAdvancedFilters() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Advanced Filters', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            _buildFilterOption('Show only hotel bookings', false),
            _buildFilterOption('Show only restaurant bookings', false),
            _buildFilterOption('Show bookings from last 3 months', true),
            _buildFilterOption('Show bookings above ETB 10,000', false),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Filters applied')),
                      );
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterOption(String label, bool value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(child: Text(label)),
          Switch(value: value, onChanged: (v) {}, activeColor: const Color(0xFF0A1F3A)),
        ],
      ),
    );
  }

  void _cancelBooking(String bookingId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Booking'),
        content: const Text('Are you sure you want to cancel this booking?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('No')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                final booking = _allBookings.firstWhere((b) => b['id'] == bookingId);
                booking['status'] = 'Cancelled';
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Booking cancelled')),
              );
            },
            child: const Text('Yes, Cancel', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _viewBookingDetails(String bookingId) {
    final booking = _allBookings.firstWhere((b) => b['id'] == bookingId);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Booking #${booking['id']}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hotel: ${booking['hotel']}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text('Dates: ${booking['date']}'),
            Text('Room: ${booking['room']}'),
            Text('Guests: ${booking['guests']}'),
            Text('Nights: ${booking['nights']}'),
            const SizedBox(height: 10),
            Text('Total: ETB ${booking['amount']}', style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}