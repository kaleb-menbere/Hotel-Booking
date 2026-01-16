// help_center_page.dart - Add the missing part
import 'package:flutter/material.dart';

class HelpCenterPage extends StatefulWidget {
  @override
  _HelpCenterPageState createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredFAQs = [];
  List<Map<String, dynamic>> _allFAQs = [];

  @override
  void initState() {
    super.initState();
    _initializeFAQs();
    _filteredFAQs = _allFAQs;
  }

  void _initializeFAQs() {
    _allFAQs = [
      {
        'category': 'Booking',
        'questions': [
          {
            'question': 'How do I book a hotel?',
            'answer': 'To book a hotel, search for your destination, select dates, choose a hotel, and proceed to payment.',
            'expanded': false
          },
          {
            'question': 'Can I modify my booking?',
            'answer': 'Yes, you can modify your booking from the Bookings section, subject to hotel policies.',
            'expanded': false
          },
          {
            'question': 'How do I cancel a booking?',
            'answer': 'Go to Bookings > Select booking > Cancel. Refund depends on hotel cancellation policy.',
            'expanded': false
          },
        ]
      },
      {
        'category': 'Payments',
        'questions': [
          {
            'question': 'What payment methods are accepted?',
            'answer': 'We accept Chapa, CBE Birr, Telebirr, credit cards, and mobile banking.',
            'expanded': false
          },
          {
            'question': 'Is my payment secure?',
            'answer': 'Yes, we use encrypted payment gateways and never store your card details.',
            'expanded': false
          },
          {
            'question': 'When will I get my refund?',
            'answer': 'Refunds are processed within 5-10 business days depending on your bank.',
            'expanded': false
          },
        ]
      },
      {
        'category': 'Account',
        'questions': [
          {
            'question': 'How do I reset my password?',
            'answer': 'Go to Login > Forgot Password. You\'ll receive reset instructions via email.',
            'expanded': false
          },
          {
            'question': 'Can I use multiple devices?',
            'answer': 'Yes, you can access your account from multiple devices.',
            'expanded': false
          },
          {
            'question': 'How do I update my profile?',
            'answer': 'Go to Profile > Personal Info to update your details.',
            'expanded': false
          },
        ]
      },
      {
        'category': 'Technical',
        'questions': [
          {
            'question': 'The app is not loading',
            'answer': 'Check your internet connection or try restarting the app.',
            'expanded': false
          },
          {
            'question': 'I can\'t receive OTP',
            'answer': 'Check your spam folder or request a new OTP. Ensure correct phone number.',
            'expanded': false
          },
          {
            'question': 'App keeps crashing',
            'answer': 'Update to latest version or reinstall the app.',
            'expanded': false
          },
        ]
      },
    ];
  }

  void _filterFAQs(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredFAQs = _allFAQs;
      });
      return;
    }

    List<Map<String, dynamic>> filtered = [];
    for (var category in _allFAQs) {
      List<Map<String, dynamic>> filteredQuestions = [];
      
      for (var question in category['questions'] as List) {
        if (question['question'].toLowerCase().contains(query.toLowerCase()) ||
            question['answer'].toLowerCase().contains(query.toLowerCase())) {
          filteredQuestions.add(question);
        }
      }
      
      if (filteredQuestions.isNotEmpty) {
        filtered.add({
          'category': category['category'],
          'questions': filteredQuestions
        });
      }
    }

    setState(() {
      _filteredFAQs = filtered;
    });
  }

  void _toggleQuestion(int categoryIndex, int questionIndex) {
    setState(() {
      _filteredFAQs[categoryIndex]['questions'][questionIndex]['expanded'] = 
        !_filteredFAQs[categoryIndex]['questions'][questionIndex]['expanded'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
        backgroundColor: Colors.blue[900],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: _buildFAQList(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomActions(),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for help...',
          prefixIcon: Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _filterFAQs('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        onChanged: _filterFAQs,
      ),
    );
  }

  Widget _buildFAQList() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
      itemCount: _filteredFAQs.length,
      itemBuilder: (context, categoryIndex) {
        final category = _filteredFAQs[categoryIndex];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          child: ExpansionTile(
            leading: Icon(Icons.help_outline, color: Colors.blue[700]),
            title: Text(
              category['category'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            children: (category['questions'] as List).map<Widget>((question) {
              final questionIndex = (category['questions'] as List).indexOf(question);
              return ListTile(
                title: Text(
                  question['question'],
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: question['expanded']
                    ? Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          question['answer'],
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      )
                    : null,
                trailing: Icon(
                  question['expanded'] ? Icons.expand_less : Icons.expand_more,
                ),
                onTap: () => _toggleQuestion(categoryIndex, questionIndex),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/contact-support'),
              icon: Icon(Icons.chat),
              label: Text('Contact Support'),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // TODO: Implement call support
                _showSnackbar('Calling support...');
              },
              icon: Icon(Icons.phone),
              label: Text('Call Now'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}