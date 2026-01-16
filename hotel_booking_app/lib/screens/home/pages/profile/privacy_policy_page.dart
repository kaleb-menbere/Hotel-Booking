// lib/screens/home/pages/profile/privacy_policy_page.dart
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24),
            _buildPolicyContent(),
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
            Icon(
              Icons.privacy_tip,
              size: 60,
              color: Colors.blue[900],
            ),
            SizedBox(height: 16),
            Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Last Updated: January 2024',
              style: TextStyle(
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Your privacy is important to us. This policy explains how we collect, use, and protect your information.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicyContent() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPolicySection(
              '1. Information We Collect',
              'We collect information you provide directly to us, such as when you create an account, make a booking, or contact customer support. This includes:\n\n• Personal information (name, email, phone number)\n• Payment information\n• Booking details\n• Communication preferences',
            ),
            _buildPolicySection(
              '2. How We Use Your Information',
              'We use the information we collect to:\n\n• Provide, maintain, and improve our services\n• Process your bookings and payments\n• Send you booking confirmations and updates\n• Respond to your comments and questions\n• Detect, investigate, and prevent fraudulent transactions',
            ),
            _buildPolicySection(
              '3. Information Sharing',
              'We do not sell your personal information. We may share your information with:\n\n• Hotels you book with (only necessary information)\n• Payment processors to complete transactions\n• Legal authorities when required by law\n• Service providers who assist in our operations',
            ),
            _buildPolicySection(
              '4. Data Security',
              'We implement appropriate technical and organizational security measures to protect your personal information against unauthorized access, alteration, disclosure, or destruction.',
            ),
            _buildPolicySection(
              '5. Your Rights',
              'You have the right to:\n\n• Access your personal information\n• Correct inaccurate information\n• Delete your personal information\n• Object to processing of your information\n• Data portability',
            ),
            _buildPolicySection(
              '6. Cookies and Tracking',
              'We use cookies and similar tracking technologies to track activity on our app and hold certain information to improve user experience.',
            ),
            _buildPolicySection(
              '7. Children\'s Privacy',
              'Our services are not intended for individuals under the age of 18. We do not knowingly collect personal information from children.',
            ),
            _buildPolicySection(
              '8. Changes to This Policy',
              'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
            ),
            _buildPolicySection(
              '9. Contact Us',
              'If you have any questions about this Privacy Policy, please contact us at privacy@ethiostay.com.',
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),
            Text(
              'For users in Ethiopia:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('We comply with Ethiopian data protection regulations'),
            _buildBulletPoint('Your data is stored on secure servers within Ethiopia'),
            _buildBulletPoint('We work with Ethiopian regulatory authorities'),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 4, right: 8),
            child: Icon(Icons.circle, size: 8, color: Colors.blue[700]),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}