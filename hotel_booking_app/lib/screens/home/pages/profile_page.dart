import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          // Profile Header
          Container(
            height: 200,
            color: const Color(0xFF0A1F3A),
            padding: const EdgeInsets.only(top: 50),
            child: const Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 60, color: Color(0xFF0A1F3A)),
                ),
                SizedBox(height: 15),
                Text(
                  'John Doe',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 10),
                Text(
                  'Member since Jan 2024',
                  style: TextStyle(color: Colors.white60, fontSize: 12),
                ),
              ],
            ),
          ),

          // Stats
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _statItem('12', 'Bookings'),
                _statItem('4', 'Favorites'),
                _statItem('2', 'Reviews'),
                _statItem('Gold', 'Tier'),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _menuItem(Icons.edit, 'Edit Profile', 'Update your personal information'),
                _menuItem(Icons.notifications, 'Notifications', 'Manage your notifications'),
                _menuItem(Icons.payment, 'Payment Methods', 'Add or remove payment methods'),
                _menuItem(Icons.bookmark, 'My Bookings', 'View all your reservations'),
                _menuItem(Icons.favorite, 'Favorites', 'Your saved hotels'),
                _menuItem(Icons.security, 'Privacy & Security', 'Manage your account security'),
                _menuItem(Icons.help, 'Help & Support', 'Get help with the app'),
                _menuItem(Icons.settings, 'Settings', 'App settings and preferences'),
                const SizedBox(height: 20),
                Card(
                  color: Colors.red[50],
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.red[700]),
                    title: Text('Logout', style: TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold)),
                    subtitle: const Text('Sign out of your account'),
                    trailing: Icon(Icons.chevron_right, color: Colors.red[700]),
                    onTap: () {
                      // Logout logic
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0A1F3A)),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }

  Widget _menuItem(IconData icon, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF0A1F3A)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {
          // Handle menu item tap
        },
      ),
    );
  }
}