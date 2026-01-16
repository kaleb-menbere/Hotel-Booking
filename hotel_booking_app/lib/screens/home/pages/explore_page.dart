import 'package:flutter/material.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore Hotels',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'Discover amazing places to stay',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: [
                _hotelCard(
                  'Sheraton Addis',
                  'Luxury 5-star hotel in city center',
                  'ETB 8,500',
                  Icons.star,
                  Colors.amber,
                  '4.8',
                ),
                _hotelCard(
                  'Hilton Addis Ababa',
                  'Business hotel with conference facilities',
                  'ETB 6,200',
                  Icons.business_center,
                  Colors.blue,
                  '4.6',
                ),
                _hotelCard(
                  'Radisson Blu',
                  'Modern hotel with great views',
                  'ETB 5,800',
                  Icons.location_city,
                  Colors.green,
                  '4.5',
                ),
                _hotelCard(
                  'Skylight Hotel',
                  'Near Bole International Airport',
                  'ETB 4,500',
                  Icons.flight_takeoff,
                  Colors.purple,
                  '4.3',
                ),
                _hotelCard(
                  'Jupiter Hotel',
                  'Budget friendly with free breakfast',
                  'ETB 1,200',
                  Icons.attach_money,
                  Colors.green,
                  '4.0',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _hotelCard(String name, String desc, String price, IconData icon, Color color, String rating) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(desc, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                const SizedBox(width: 4),
                Text(rating, style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(width: 8),
                Icon(Icons.wifi, color: Colors.grey[600], size: 16),
                const SizedBox(width: 4),
                Icon(Icons.restaurant, color: Colors.grey[600], size: 16),
                const SizedBox(width: 4),
                Icon(Icons.local_parking, color: Colors.grey[600], size: 16),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0A1F3A))),
            const Text('/night', style: TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A1F3A),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              ),
              child: const Text('Book', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }
}