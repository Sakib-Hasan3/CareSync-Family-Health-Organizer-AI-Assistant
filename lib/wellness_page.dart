import 'package:flutter/material.dart';

class WellnessPage extends StatelessWidget {
  const WellnessPage({super.key});

  @override
  Widget build(BuildContext context) {
    final diets = [
      {
        'plan': 'Balanced Diet',
        'details': 'Fruits, vegetables, lean proteins, whole grains.'
      },
      {'plan': 'Low Carb', 'details': 'Reduce bread, rice, and sugar.'},
    ];
    final fitness = [
      {'activity': 'Walking', 'duration': '30 min'},
      {'activity': 'Yoga', 'duration': '20 min'},
    ];
    final mentalHealth = [
      {'checkin': 'Mood', 'status': 'Good'},
      {'checkin': 'Stress', 'status': 'Low'},
      {'resource': 'Counseling', 'info': 'Call 1800-123-4567'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wellness & Lifestyle'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Diet & Nutrition Plans',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...diets.map((d) => Card(
                child: ListTile(
                  leading: const Icon(Icons.restaurant_menu),
                  title: Text(d['plan'].toString()),
                  subtitle: Text(d['details'].toString()),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Fitness Activity Tracking',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...fitness.map((f) => Card(
                child: ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(f['activity'].toString()),
                  subtitle: Text('Duration: ${f['duration']}'),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Mental Health Check-ins & Counseling',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...mentalHealth.map((m) => Card(
                child: ListTile(
                  leading: const Icon(Icons.psychology),
                  title: Text(
                      m['checkin']?.toString() ?? m['resource'].toString()),
                  subtitle:
                      Text(m['status']?.toString() ?? m['info'].toString()),
                ),
              )),
        ],
      ),
    );
  }
}
