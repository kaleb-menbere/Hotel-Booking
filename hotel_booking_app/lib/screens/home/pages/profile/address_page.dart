import 'package:flutter/material.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final List<Map<String, String>> _addresses = [
    {'type': 'Home', 'address': 'Bole, Addis Ababa\nEthiopia', 'isDefault': 'true'},
    {'type': 'Work', 'address': 'Kirkos, Addis Ababa\nEthiopia', 'isDefault': 'false'},
    {'type': 'Other', 'address': 'Megenagna, Addis Ababa\nEthiopia', 'isDefault': 'false'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Addresses')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                return _buildAddressCard(_addresses[index], index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _addNewAddress(context),
                icon: const Icon(Icons.add),
                label: const Text('Add New Address'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, String> address, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        leading: Icon(
          address['type'] == 'Home' ? Icons.home : 
          address['type'] == 'Work' ? Icons.work : Icons.location_on,
          color: const Color(0xFF0A1F3A),
          size: 30,
        ),
        title: Text(
          address['type']!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(address['address']!),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (address['isDefault'] == 'false')
              IconButton(
                icon: const Icon(Icons.star_border, color: Colors.grey),
                onPressed: () => _setAsDefault(index),
              ),
            if (address['isDefault'] == 'true')
              const Icon(Icons.star, color: Colors.amber),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.grey),
              onPressed: () => _editAddress(index, context),
            ),
          ],
        ),
      ),
    );
  }

  void _addNewAddress(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(decoration: const InputDecoration(labelText: 'Address Type (Home/Work/Other)')),
              const SizedBox(height: 10),
              TextField(decoration: const InputDecoration(labelText: 'Street Address'), maxLines: 2),
              const SizedBox(height: 10),
              TextField(decoration: const InputDecoration(labelText: 'City')),
              const SizedBox(height: 10),
              TextField(decoration: const InputDecoration(labelText: 'Country')),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address added successfully')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _setAsDefault(int index) {
    setState(() {
      for (var address in _addresses) {
        address['isDefault'] = 'false';
      }
      _addresses[index]['isDefault'] = 'true';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Default address updated')),
    );
  }

  void _editAddress(int index, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Address'),
        content: Text('Editing ${_addresses[index]['type']} address'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Address updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}