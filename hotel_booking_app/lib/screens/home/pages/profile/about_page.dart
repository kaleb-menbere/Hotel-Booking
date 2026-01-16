// about_page.dart
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About EthioStay'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24),
            _buildMissionVision(),
            SizedBox(height: 24),
            _buildTeam(),
            SizedBox(height: 24),
            _buildFeatures(),
            SizedBox(height: 24),
            _buildSocialLinks(),
            SizedBox(height: 24),
            _buildAppInfo(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[50],
              child: Icon(
                Icons.hotel,
                size: 60,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'EthioStay',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Your Gateway to Ethiopian Hospitality',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMissionVision() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Mission & Vision',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 12),
            _buildInfoItem(
              Icons.flag,
              'Mission',
              'To make hotel booking in Ethiopia seamless, accessible, and trustworthy for both travelers and hotel owners.',
            ),
            _buildInfoItem(
              Icons.remove_red_eye,
              'Vision',
              'To become Ethiopia\'s leading hotel booking platform, promoting tourism and supporting local businesses.',
            ),
            _buildInfoItem(
              Icons.favorite,
              'Values',
              'Trust, Convenience, Customer Satisfaction, and Supporting Local Economy.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue[700], size: 24),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeam() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Team',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 12),
            Text(
              'We are a passionate team of Ethiopian developers and travel enthusiasts dedicated to improving the travel experience in Ethiopia.',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildTeamMember('Alex', 'Tech Lead'),
                _buildTeamMember('Sara', 'UX Designer'),
                _buildTeamMember('Michael', 'Backend Dev'),
                _buildTeamMember('Liya', 'Marketing'),
                _buildTeamMember('Daniel', 'Mobile Dev'),
                _buildTeamMember('Hanna', 'Support'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name, String role) {
    return Container(
      width: 100,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            child: Text(
              name[0],
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          Text(
            role,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures() {
    final features = [
      {'icon': Icons.hotel, 'title': 'Hotels', 'desc': '200+ hotels across Ethiopia'},
      {'icon': Icons.map, 'title': 'Maps', 'desc': 'Interactive maps with directions'},
      {'icon': Icons.payment, 'title': 'Payments', 'desc': 'Secure local payment options'},
      {'icon': Icons.star, 'title': 'Reviews', 'desc': 'Verified guest reviews'},
      {'icon': Icons.support_agent, 'title': '24/7 Support', 'desc': 'Always here to help'},
      {'icon': Icons.security, 'title': 'Secure', 'desc': 'Your data is protected'},
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Why Choose EthioStay?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2,
              children: features.map((feature) {
                return Card(
                  elevation: 2,
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(feature['icon'] as IconData, color: Colors.blue[700], size: 24),
                        SizedBox(height: 8),
                        Text(
                          feature['title'] as String,
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                        ),
                        Text(
                          feature['desc'] as String,
                          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connect With Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSocialButton(Icons.facebook, 'Facebook', Colors.blue[800]!),
                _buildSocialButton(Icons.telegram, 'Telegram', Colors.blue[400]!),
                _buildSocialButton(Icons.email, 'Email', Colors.red),
                _buildSocialButton(Icons.web, 'Website', Colors.green),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton(IconData icon, String label, Color color) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          color: color,
          iconSize: 32,
          onPressed: () => _launchSocial(label.toLowerCase()),
        ),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildAppInfo(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 12),
            _buildInfoRow('Version', '1.0.0'),
            _buildInfoRow('Last Updated', 'January 2024'),
            _buildInfoRow('Developed By', 'EthioStay Team'),
            _buildInfoRow('Platform', 'Android & iOS'),
            _buildInfoRow('Support Email', 'support@ethiostay.com'),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/privacy-policy'),
                  icon: Icon(Icons.privacy_tip),
                  label: Text('Privacy Policy'),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/terms'),
                  icon: Icon(Icons.description),
                  label: Text('Terms of Service'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  void _launchSocial(String platform) {
    final urls = {
      'facebook': 'https://facebook.com/ethiostay',
      'telegram': 'https://t.me/ethiostay',
      'email': 'mailto:info@ethiostay.com',
      'website': 'https://ethiostay.com',
    };
    
    // TODO: Implement URL launching
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Opening $platform...'),
    //     duration: Duration(seconds: 1),
    //   ),
    // );
  }
}