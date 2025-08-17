import 'package:flutter/material.dart';

class TelehealthPage extends StatelessWidget {
  const TelehealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telehealth Consultation'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.video_call, size: 80, color: Colors.teal),
            const SizedBox(height: 20),
            const Text('Start a video/audio consultation with a doctor'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Simulate joining a video call
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Joining video consultation...')),
                );
              },
              child: const Text('Join Consultation'),
            ),
          ],
        ),
      ),
    );
  }
}
