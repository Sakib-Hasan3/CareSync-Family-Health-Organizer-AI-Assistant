import 'package:flutter/material.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bills = [
      {'title': 'Consultation Fee', 'amount': 500, 'status': 'Unpaid'},
      {'title': 'Lab Test', 'amount': 1200, 'status': 'Paid'},
    ];
    final insuranceProviders = [
      'HealthCare Plus',
      'Family Secure',
      'MediAssist',
    ];
    final plans = [
      {'name': 'Basic Family', 'price': 999, 'features': 'Up to 4 members'},
      {
        'name': 'Premium Family',
        'price': 1999,
        'features': 'Up to 8 members + extra benefits'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payments & Insurance'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Digital Billing:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...bills.map((bill) => Card(
                child: ListTile(
                  title: Text(bill['title'].toString()),
                  subtitle: Text('Amount: ₹${bill['amount']}'),
                  trailing: bill['status'] == 'Unpaid'
                      ? ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Payment gateway coming soon!')),
                            );
                          },
                          child: const Text('Pay'),
                        )
                      : const Text('Paid',
                          style: TextStyle(color: Colors.green)),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Insurance Providers:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...insuranceProviders.map((provider) => Card(
                child: ListTile(
                  leading: const Icon(Icons.verified_user),
                  title: Text(provider),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Integration with $provider coming soon!')),
                      );
                    },
                    child: const Text('Link'),
                  ),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Subscription Plans:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...plans.map((plan) => Card(
                child: ListTile(
                  title: Text(plan['name'].toString()),
                  subtitle: Text(
                      '${plan['features']}\nPrice: ₹${plan['price']} / year'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Subscribe to ${plan['name']} coming soon!')),
                      );
                    },
                    child: const Text('Subscribe'),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
