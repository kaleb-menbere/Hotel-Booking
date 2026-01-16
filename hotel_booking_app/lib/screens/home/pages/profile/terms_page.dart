import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Service'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 24),
            _buildTermsContent(),
            SizedBox(height: 32),
            _buildAcceptanceButton(),
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
              Icons.gavel,
              size: 60,
              color: Colors.blue[900],
            ),
            SizedBox(height: 16),
            Text(
              'EthioStay Terms of Service',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
              textAlign: TextAlign.center,
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
              'By using EthioStay, you agree to these terms. Please read them carefully.',
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

  Widget _buildTermsContent() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTermSection(
              '1. Acceptance of Terms',
              'By accessing or using the EthioStay platform, you agree to be bound by these Terms of Service. If you disagree with any part of the terms, you may not access the service.',
            ),
            _buildTermSection(
              '2. User Accounts',
              'You must be at least 18 years old to create an account. You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.',
            ),
            _buildTermSection(
              '3. Booking Services',
              'EthioStay acts as an intermediary between users and hotel providers. We are not responsible for the quality, safety, or legality of the accommodations listed. All bookings are subject to availability and confirmation by the hotel.',
            ),
            _buildTermSection(
              '4. Payments and Cancellations',
              'All payments are processed through secure payment gateways. Cancellation policies vary by hotel and are displayed during booking. Refunds are processed according to the hotel\'s cancellation policy.',
            ),
            _buildTermSection(
              '5. User Conduct',
              'You agree not to use the service for any unlawful purpose. You must not harass, threaten, or impersonate other users. Any fraudulent activity will result in immediate account termination.',
            ),
            _buildTermSection(
              '6. Content and Reviews',
              'Users may post reviews and content. You grant EthioStay a non-exclusive license to use this content. Reviews must be truthful and not contain offensive or inappropriate material.',
            ),
            _buildTermSection(
              '7. Intellectual Property',
              'All content on EthioStay, including logos, text, and software, is the property of EthioStay or its licensors and is protected by copyright and other intellectual property laws.',
            ),
            _buildTermSection(
              '8. Limitation of Liability',
              'EthioStay shall not be liable for any indirect, incidental, special, consequential or punitive damages resulting from your use of or inability to use the service.',
            ),
            _buildTermSection(
              '9. Privacy',
              'Your use of EthioStay is also governed by our Privacy Policy. Please review our Privacy Policy, which explains how we collect, use, and protect your personal information.',
            ),
            _buildTermSection(
              '10. Modifications to Terms',
              'We reserve the right to modify these terms at any time. We will notify users of any changes by posting the new Terms of Service on this page. Continued use after changes constitutes acceptance.',
            ),
            _buildTermSection(
              '11. Governing Law',
              'These terms shall be governed by and construed in accordance with the laws of the Federal Democratic Republic of Ethiopia, without regard to its conflict of law provisions.',
            ),
            _buildTermSection(
              '12. Contact Information',
              'For any questions about these Terms of Service, please contact us at legal@ethiostay.com or through our contact page.',
            ),
            SizedBox(height: 24),
            Divider(),
            SizedBox(height: 16),
            Text(
              'Important Notes:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.red[700],
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Prices are subject to change without notice'),
            _buildBulletPoint('Hotel ratings are based on user reviews'),
            _buildBulletPoint('We reserve the right to refuse service to anyone'),
            _buildBulletPoint('Force majeure events may affect bookings'),
          ],
        ),
      ),
    );
  }

  Widget _buildTermSection(String title, String content) {
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

  Widget _buildAcceptanceButton() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              Icons.verified_user,
              size: 50,
              color: Colors.green,
            ),
            SizedBox(height: 16),
            Text(
              'By using EthioStay, you acknowledge that you have read, understood, and agree to be bound by these Terms of Service.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO: Show terms history
                    },
                    child: Text('View Previous Versions'),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Mark as read/agreed
                    },
                    child: Text('I Understand'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}