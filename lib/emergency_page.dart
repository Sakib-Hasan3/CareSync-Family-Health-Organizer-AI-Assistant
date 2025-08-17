import 'package:flutter/material.dart';

class EmergencyPage extends StatelessWidget {
  const EmergencyPage({super.key});

  void _showSOS(BuildContext context) {
    // Simulate location sharing and SOS
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('SOS sent! Location shared with emergency contacts.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final helplines = [
      {'name': 'Ambulance', 'number': '102'},
      {'name': 'Police', 'number': '100'},
      {'name': 'Fire', 'number': '101'},
      {'name': 'Local Hospital', 'number': '123-456-7890'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency & Support'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Quick Access to Emergency Helplines:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...helplines.map((h) => Card(
                child: ListTile(
                  leading: const Icon(Icons.phone_in_talk),
                  title: Text(h['name']!),
                  subtitle: Text('Call: ${h['number']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.call),
                    onPressed: () {
                      // Simulate call
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Calling ${h['number']}...')),
                      );
                    },
                  ),
                ),
              )),
          const SizedBox(height: 30),
          Center(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.sos, color: Colors.red),
              label: const Text('SOS'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              onPressed: () => _showSOS(context),
            ),
          ),
          const SizedBox(height: 20),
          const Text('Integrated with local hospitals and ambulance services.',
              style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
