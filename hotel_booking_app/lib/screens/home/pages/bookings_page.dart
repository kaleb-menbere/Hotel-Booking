import 'package:flutter/material.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Bookings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Manage your reservations',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _bookingCard(
                  'Sheraton Addis',
                  'Confirmed',
                  'Jan 15-20, 2024 (5 nights)',
                  'ETB 42,500',
                  'Booking #ETH2345',
                  Colors.green,
                ),
                _bookingCard(
                  'Hilton Addis Ababa',
                  'Completed',
                  'Dec 10-12, 2023 (2 nights)',
                  'ETB 12,400',
                  'Booking #ETH1892',
                  Colors.blue,
                ),
                _bookingCard(
                  'Radisson Blu',
                  'Upcoming',
                  'Feb 5-8, 2024 (3 nights)',
                  'ETB 17,400',
                  'Booking #ETH2678',
                  Colors.orange,
                ),
                _bookingCard(
                  'Jupiter Hotel',
                  'Cancelled',
                  'Nov 20-22, 2023 (2 nights)',
                  'ETB 3,600',
                  'Booking #ETH1567',
                  Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bookingCard(String hotel, String status, String dates, String total, String bookingId, Color statusColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.hotel, size: 40, color: Color(0xFF0A1F3A)),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(hotel, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 5),
                      Text(bookingId, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
                    status,
                    style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(dates, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: $total',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0A1F3A)),
                ),
                Row(
                  children: [
                    if (status == 'Upcoming' || status == 'Confirmed')
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.red),
                        ),
                        child: const Text('Cancel', style: TextStyle(color: Colors.red)),
                      ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A1F3A),
                      ),
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
}