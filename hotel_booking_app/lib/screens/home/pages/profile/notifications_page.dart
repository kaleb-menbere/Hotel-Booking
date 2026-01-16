import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _bookingNotifications = true;
  bool _promotionNotifications = true;
  bool _priceDropNotifications = false;
  bool _newHotelNotifications = true;
  bool _emailNotifications = false;
  bool _pushNotifications = true;
  bool _smsNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Notification Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildNotificationSection('Booking Updates', [
              _buildSwitchItem('Booking confirmations & reminders', _bookingNotifications, (value) {
                setState(() => _bookingNotifications = value);
              }),
              _buildSwitchItem('Check-in/check-out reminders', _promotionNotifications, (value) {
                setState(() => _promotionNotifications = value);
              }),
            ]),
            const SizedBox(height: 25),
            _buildNotificationSection('Deals & Promotions', [
              _buildSwitchItem('Price drop alerts', _priceDropNotifications, (value) {
                setState(() => _priceDropNotifications = value);
              }),
              _buildSwitchItem('New hotel alerts in your area', _newHotelNotifications, (value) {
                setState(() => _newHotelNotifications = value);
              }),
            ]),
            const SizedBox(height: 25),
            _buildNotificationSection('Notification Methods', [
              _buildSwitchItem('Email notifications', _emailNotifications, (value) {
                setState(() => _emailNotifications = value);
              }),
              _buildSwitchItem('Push notifications', _pushNotifications, (value) {
                setState(() => _pushNotifications = value);
              }),
              _buildSwitchItem('SMS notifications', _smsNotifications, (value) {
                setState(() => _smsNotifications = value);
              }),
            ]),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16)),
                child: const Text('Save Settings'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 15),
        ...children,
      ],
    );
  }

  Widget _buildSwitchItem(String label, bool value, ValueChanged<bool> onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF0A1F3A),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Notification settings saved!')),
    );
  }
}