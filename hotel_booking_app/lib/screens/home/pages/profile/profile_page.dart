// lib/screens/home/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/personal_info_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/address_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/notifications_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/privacy_security_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/payment_methods_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/my_bookings_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/favorites_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/reviews_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/help_center_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/contact_support_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/privacy_policy_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/terms_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/settings_page.dart';
import 'package:hotel_booking_app/screens/home/pages/profile/about_page.dart';
import 'package:hotel_booking_app/utils/routes.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            _buildProfileMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 50, color: Colors.blue[900]),
          ),
          SizedBox(height: 16),
          Text(
            'John Doe',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'johndoe@email.com',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('Bookings', '12'),
              _buildStatItem('Reviews', '8'),
              _buildStatItem('Favorites', '15'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileMenu(BuildContext context) {
    final List<Map<String, dynamic>> menuItems = [
      {'icon': Icons.person, 'title': 'Personal Information', 'page': PersonalInfoPage()},
      {'icon': Icons.location_on, 'title': 'My Addresses', 'page': AddressPage()},
      {'icon': Icons.notifications, 'title': 'Notifications', 'page': NotificationsPage()},
      {'icon': Icons.security, 'title': 'Privacy & Security', 'page': PrivacySecurityPage()},
      {'icon': Icons.payment, 'title': 'Payment Methods', 'page': PaymentMethodsPage()},
      {'icon': Icons.book, 'title': 'My Bookings', 'page': MyBookingsPage()},
      {'icon': Icons.favorite, 'title': 'Favorites', 'page': FavoritesPage()},
      {'icon': Icons.star, 'title': 'My Reviews', 'page': ReviewsPage()},
      {'icon': Icons.help, 'title': 'Help Center', 'page': HelpCenterPage()},
      {'icon': Icons.support_agent, 'title': 'Contact Support', 'page': ContactSupportPage()},
      {'icon': Icons.privacy_tip, 'title': 'Privacy Policy', 'page': PrivacyPolicyPage()},
      {'icon': Icons.description, 'title': 'Terms of Service', 'page': TermsPage()},
      {'icon': Icons.settings, 'title': 'Settings', 'page': SettingsPage()},
      {'icon': Icons.info, 'title': 'About EthioStay', 'page': AboutPage()},
      {'icon': Icons.logout, 'title': 'Logout', 'action': 'logout'},
    ];

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: menuItems.map((item) {
          return Card(
            elevation: 1,
            margin: EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(item['icon'], color: Colors.blue[700]),
              title: Text(item['title']),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                if (item['action'] == 'logout') {
                  _showLogoutDialog(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => item['page']),
                  );
                }
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: Text('Logout'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}