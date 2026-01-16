import 'package:flutter/material.dart';

class PrivacySecurityPage extends StatefulWidget {
  @override
  _PrivacySecurityPageState createState() => _PrivacySecurityPageState();
}

class _PrivacySecurityPageState extends State<PrivacySecurityPage> {
  bool _biometricEnabled = false;
  bool _twoFactorEnabled = false;
  bool _emailNotifications = true;
  bool _smsNotifications = true;
  bool _locationTracking = true;
  bool _dataCollection = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy & Security'),
        backgroundColor: Colors.blue[900],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSecuritySection(),
            SizedBox(height: 24),
            _buildPrivacySection(),
            SizedBox(height: 24),
            _buildDataSection(),
            SizedBox(height: 24),
            _buildPermissionsSection(),
            SizedBox(height: 32),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Security Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildSecuritySwitch(
              'Biometric Login',
              'Use fingerprint or face recognition for login',
              _biometricEnabled,
              (value) => setState(() => _biometricEnabled = value),
            ),
            _buildSecuritySwitch(
              'Two-Factor Authentication',
              'Add an extra layer of security to your account',
              _twoFactorEnabled,
              (value) => setState(() => _twoFactorEnabled = value),
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.password, color: Colors.blue[700]),
              title: Text('Change Password'),
              subtitle: Text('Update your account password'),
              trailing: Icon(Icons.chevron_right),
              onTap: _changePassword,
            ),
            ListTile(
              leading: Icon(Icons.devices, color: Colors.blue[700]),
              title: Text('Active Sessions'),
              subtitle: Text('Manage your logged-in devices'),
              trailing: Icon(Icons.chevron_right),
              onTap: _viewActiveSessions,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.privacy_tip, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Privacy Settings',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildPrivacySwitch(
              'Email Notifications',
              'Receive booking updates via email',
              _emailNotifications,
              (value) => setState(() => _emailNotifications = value),
            ),
            _buildPrivacySwitch(
              'SMS Notifications',
              'Receive booking updates via SMS',
              _smsNotifications,
              (value) => setState(() => _smsNotifications = value),
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.visibility_off, color: Colors.blue[700]),
              title: Text('Profile Visibility'),
              subtitle: Text('Control who can see your profile'),
              trailing: Icon(Icons.chevron_right),
              onTap: _manageProfileVisibility,
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.blue[700]),
              title: Text('Delete Account'),
              subtitle: Text('Permanently delete your account'),
              trailing: Icon(Icons.chevron_right),
              onTap: _deleteAccount,
            ),
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
                Icon(Icons.data_usage, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'Data & Personalization',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildDataSwitch(
              'Location Tracking',
              'Allow us to use your location for better recommendations',
              _locationTracking,
              (value) => setState(() => _locationTracking = value),
            ),
            _buildDataSwitch(
              'Data Collection',
              'Help improve EthioStay by sharing usage data',
              _dataCollection,
              (value) => setState(() => _dataCollection = value),
            ),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.download, color: Colors.blue[700]),
              title: Text('Download Your Data'),
              subtitle: Text('Get a copy of your personal data'),
              trailing: Icon(Icons.chevron_right),
              onTap: _downloadData,
            ),
            ListTile(
              leading: Icon(Icons.clear_all, color: Colors.blue[700]),
              title: Text('Clear Search History'),
              subtitle: Text('Remove your recent searches'),
              trailing: Icon(Icons.chevron_right),
              onTap: _clearSearchHistory,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionsSection() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.admin_panel_settings, color: Colors.blue[700]),
                SizedBox(width: 8),
                Text(
                  'App Permissions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            _buildPermissionItem(
              'Location',
              'Required for nearby hotel searches',
              true,
            ),
            _buildPermissionItem(
              'Camera',
              'For profile pictures and document upload',
              true,
            ),
            _buildPermissionItem(
              'Storage',
              'To save booking confirmations',
              true,
            ),
            _buildPermissionItem(
              'Notifications',
              'For booking updates and offers',
              true,
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _managePermissions,
              child: Text('Manage Permissions in Settings'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecuritySwitch(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue[900],
    );
  }

  Widget _buildPrivacySwitch(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue[900],
    );
  }

  Widget _buildDataSwitch(String title, String subtitle, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 12)),
      value: value,
      onChanged: onChanged,
      activeColor: Colors.blue[900],
    );
  }

  Widget _buildPermissionItem(String permission, String description, bool granted) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        granted ? Icons.check_circle : Icons.error,
        color: granted ? Colors.green : Colors.orange,
      ),
      title: Text(permission, style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(description, style: TextStyle(fontSize: 12)),
      trailing: Chip(
        label: Text(granted ? 'Granted' : 'Denied'),
        backgroundColor: granted ? Colors.green[50] : Colors.orange[50],
        labelStyle: TextStyle(color: granted ? Colors.green : Colors.orange),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _saveSettings,
            icon: Icon(Icons.save),
            label: Text('Save All Changes'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900],
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: _resetToDefaults,
            icon: Icon(Icons.restart_alt),
            label: Text('Reset to Defaults'),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ),
      ],
    );
  }

  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Current Password',
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            SizedBox(height: 12),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                prefixIcon: Icon(Icons.lock_reset),
              ),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackbar('Password changed successfully!');
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  void _viewActiveSessions() {
    // TODO: Implement active sessions view
    _showSnackbar('Opening active sessions...');
  }

  void _manageProfileVisibility() {
    // TODO: Implement profile visibility management
    _showSnackbar('Opening profile visibility settings...');
  }

  void _deleteAccount() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Account'),
        content: Text(
          'Are you sure you want to delete your account? '
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackbar('Account deletion request sent.');
            },
            child: Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _downloadData() {
    // TODO: Implement data download
    _showSnackbar('Preparing your data download...');
  }

  void _clearSearchHistory() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Search History'),
        content: Text('Are you sure you want to clear your search history?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSnackbar('Search history cleared!');
            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }

  void _managePermissions() {
    // TODO: Open app settings
    _showSnackbar('Opening app settings...');
  }

  void _saveSettings() {
    // TODO: Save settings to backend
    _showSnackbar('Settings saved successfully!');
  }

  void _resetToDefaults() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset to Defaults'),
        content: Text('Reset all privacy and security settings to defaults?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _biometricEnabled = false;
                _twoFactorEnabled = false;
                _emailNotifications = true;
                _smsNotifications = true;
                _locationTracking = true;
                _dataCollection = true;
              });
              Navigator.pop(context);
              _showSnackbar('Settings reset to defaults!');
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