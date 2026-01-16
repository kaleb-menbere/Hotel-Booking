import 'package:flutter/material.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment Methods')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildPaymentCard('Chapa', '**** **** **** 1234', Icons.credit_card, Colors.blue),
          _buildPaymentCard('CBE Birr', 'john.doe@cbe.com.et', Icons.phone_android, Colors.green),
          _buildPaymentCard('TeleBirr', '0912 345 678', Icons.phone_iphone, Colors.purple),
          _buildPaymentCard('PayPal', 'john.doe@example.com', Icons.payment, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(String type, String details, IconData icon, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: color, size: 30),
        title: Text(type, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(details),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {},
        ),
      ),
    );
  }
}