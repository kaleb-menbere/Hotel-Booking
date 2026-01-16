import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'English';
  String _selectedCurrency = 'ETB (Birr)';
  String _selectedTheme = 'Light';
  bool _notificationsEnabled = true;
  bool _autoUpdates = true;
  bool _wifiOnlyDownloads = false;
  double _fontSize = 16.0;

  final List<String> _languages = [
    'English',
    'Amharic (አማርኛ)',
    'Afan Oromo',
    'Tigrinya (ትግርኛ)'
  ];

    final List<String> _currencies = [
    'ETB (Birr)',
    'USD (\$)',
    'EUR (€)',
    'GBP (£)'
    ];

  final List<String> _themes = [
    'Light',
    'Dark',
    'System Default'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: _searchSettings,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppearanceSection(),
            SizedBox(height: 24),
            _buildLanguageCurrencySection(),
            SizedBox(height: 24),
            _buildNotificationsSection(),
            SizedBox(height: 24),
            _buildDataSection(),
            SizedBox(height: 24),
            _buildAdvancedSection(),
            SizedBox(height: 32),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppearanceSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.palette, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Appearance',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Theme', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _themes.map((theme) {
                    return ChoiceChip(
                      label: Text(theme),
                      selected: _selectedTheme == theme,
                      onSelected: (selected) {
                        setState(() {
                          _selectedTheme = theme;
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Font Size: ${_fontSize.toInt()}pt',
                    style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(height: 8),
                Slider(
                  value: _fontSize,
                  min: 12,
                  max: 24,
                  divisions: 12,
                  label: '${_fontSize.toInt()}pt',
                  onChanged: (value) {
                    setState(() {
                      _fontSize = value;
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Small', style: TextStyle(fontSize: 12)),
                    Text('Medium', style: TextStyle(fontSize: 16)),
                    Text('Large', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
            SwitchListTile(
              title: Text('Bold Text', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Use bold text style throughout the app'),
              value: false,
              onChanged: (value) {},
              activeColor: Colors.blue[900],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCurrencySection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.language, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Language & Region',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDropdownSetting(
              'Language',
              _selectedLanguage,
              _languages,
              (value) => setState(() => _selectedLanguage = value!),
              Icons.translate,
            ),
            _buildDropdownSetting(
              'Currency',
              _selectedCurrency,
              _currencies,
              (value) => setState(() => _selectedCurrency = value!),
              Icons.attach_money,
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.blue[700]),
              title: Text('Region'),
              subtitle: Text('Ethiopia (Auto-detected)'),
              trailing: Icon(Icons.chevron_right),
              onTap: _changeRegion,
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.blue[700]),
              title: Text('Time Format'),
              subtitle: Text('24-hour format'),
              trailing: Icon(Icons.chevron_right),
              onTap: _changeTimeFormat,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Enable Notifications', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Receive app notifications'),
              value: _notificationsEnabled,
              onChanged: (value) => setState(() => _notificationsEnabled = value),
              activeColor: Colors.blue[900],
            ),
            SizedBox(height: 8),
            if (_notificationsEnabled) ...[
              _buildNotificationType('Booking Confirmations', true),
              _buildNotificationType('Promotions & Offers', true),
              _buildNotificationType('Price Alerts', false),
              _buildNotificationType('Review Reminders', true),
              _buildNotificationType('Security Alerts', true),
              SizedBox(height: 8),
              ListTile(
                leading: Icon(Icons.notification_add, color: Colors.blue[700]),
                title: Text('Notification Sound'),
                subtitle: Text('Default'),
                trailing: Icon(Icons.chevron_right),
                onTap: _changeNotificationSound,
              ),
              ListTile(
                leading: Icon(Icons.vibration, color: Colors.blue[700]),
                title: Text('Vibration'),
                subtitle: Text('Enabled'),
                trailing: Icon(Icons.chevron_right),
                onTap: _changeVibration,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDataSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Data & Storage',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Auto Updates', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Automatically update app when available'),
              value: _autoUpdates,
              onChanged: (value) => setState(() => _autoUpdates = value),
              activeColor: Colors.blue[900],
            ),
            SwitchListTile(
              title: Text('Wi-Fi Only Downloads', style: TextStyle(fontWeight: FontWeight.w500)),
              subtitle: Text('Download updates only over Wi-Fi'),
              value: _wifiOnlyDownloads,
              onChanged: (value) => setState(() => _wifiOnlyDownloads = value),
              activeColor: Colors.blue[900],
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.blue[700]),
              title: Text('Image Quality'),
              subtitle: Text('Auto (Recommended)'),
              trailing: Icon(Icons.chevron_right),
              onTap: _changeImageQuality,
            ),
            ListTile(
              leading: Icon(Icons.cached, color: Colors.blue[700]),
              title: Text('Cache Size'),
              subtitle: Text('245 MB'),
              trailing: Icon(Icons.chevron_right),
              onTap: _clearCache,
            ),
            ListTile(
              leading: Icon(Icons.save_alt, color: Colors.blue[700]),
              title: Text('Offline Mode'),
              subtitle: Text('Save hotels for offline viewing'),
              trailing: Icon(Icons.chevron_right),
              onTap: _manageOfflineData,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancedSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings_applications, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Advanced',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.bug_report, color: Colors.blue[700]),
              title: Text('Report a Bug'),
              subtitle: Text('Found an issue? Let us know'),
              trailing: Icon(Icons.chevron_right),
              onTap: _reportBug,
            ),
            ListTile(
              leading: Icon(Icons.rate_review, color: Colors.blue[700]),
              title: Text('Rate the App'),
              subtitle: Text('Share your experience on store'),
              trailing: Icon(Icons.chevron_right),
              onTap: _rateApp,
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.blue[700]),
              title: Text('Share App'),
              subtitle: Text('Share EthioStay with friends'),
              trailing: Icon(Icons.chevron_right),
              onTap: _shareApp,
            ),
            ListTile(
              leading: Icon(Icons.developer_mode, color: Colors.blue[700]),
              title: Text('Developer Options'),
              subtitle: Text('Advanced settings for developers'),
              trailing: Icon(Icons.chevron_right),
              onTap: _openDeveloperOptions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownSetting(String label, String value, List<String> options, ValueChanged<String?> onChanged, IconData icon) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Icon(icon, color: Colors.blue[700]),
                SizedBox(width: 12),
                Expanded(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    underline: SizedBox(),
                    items: options.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: onChanged,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationType(String type, bool enabled) {
    return SwitchListTile(
      title: Text(type, style: TextStyle(fontWeight: FontWeight.w500)),
      value: enabled,
      onChanged: (value) {},
      contentPadding: EdgeInsets.zero,
      activeColor: Colors.blue[900],
    );
  }

  Widget _buildBottomButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _saveAllSettings,
            icon: Icon(Icons.save),
            label: Text('Save Settings'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _exportSettings,
                icon: Icon(Icons.upload),
                label: Text('Export'),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: _resetSettings,
                icon: Icon(Icons.restart_alt),
                label: Text('Reset All'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _searchSettings() {
    showSearch(
      context: context,
      delegate: SettingsSearchDelegate(),
    );
  }

  void _changeRegion() {
    // TODO: Implement region change
    _showSnackbar('Opening region settings...');
  }

  void _changeTimeFormat() {
    // TODO: Implement time format change
    _showSnackbar('Opening time format settings...');
  }

  void _changeNotificationSound() {
    // TODO: Implement notification sound change
    _showSnackbar('Opening notification sounds...');
  }

  void _changeVibration() {
    // TODO: Implement vibration settings
    _showSnackbar('Opening vibration settings...');
  }

  void _changeImageQuality() {
    // TODO: Implement image quality settings
    _showSnackbar('Opening image quality settings...');
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cache'),
        content: Text('Clear 245 MB of cached data?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackbar('Cache cleared successfully!');
            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _manageOfflineData() {
    // TODO: Implement offline data management
    _showSnackbar('Opening offline data settings...');
  }

  void _reportBug() {
    // TODO: Implement bug reporting
    _showSnackbar('Opening bug report form...');
  }

  void _rateApp() {
    // TODO: Implement app rating
    _showSnackbar('Opening app store...');
  }

  void _shareApp() {
    // TODO: Implement app sharing
    _showSnackbar('Sharing EthioStay...');
  }

  void _openDeveloperOptions() {
    // TODO: Implement developer options
    _showSnackbar('Opening developer options...');
  }

  void _saveAllSettings() {
    // TODO: Save settings to backend
    _showSnackbar('Settings saved successfully!');
  }

  void _exportSettings() {
    // TODO: Implement settings export
    _showSnackbar('Exporting settings...');
  }

  void _resetSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset All Settings'),
        content: Text('Reset all settings to default values?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _selectedLanguage = 'English';
                _selectedCurrency = 'ETB (Birr)';
                _selectedTheme = 'Light';
                _notificationsEnabled = true;
                _autoUpdates = true;
                _wifiOnlyDownloads = false;
                _fontSize = 16.0;
              });
              Navigator.pop(context);
              _showSnackbar('All settings reset to defaults!');
            },
            child: Text('Reset'),
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
}

class SettingsSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text('Search results for: $query'),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestions = [
      'Theme',
      'Language',
      'Currency',
      'Notifications',
      'Privacy',
      'Security',
      'Cache',
      'Updates',
      'Offline Mode',
      'Help',
      'About',
      'Contact',
    ].where((item) => item.toLowerCase().contains(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            // TODO: Navigate to relevant setting
          },
        );
      },
    );
  }
}