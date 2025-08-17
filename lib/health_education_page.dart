import 'package:flutter/material.dart';

class HealthEducationPage extends StatelessWidget {
  const HealthEducationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final articles = [
      {
        'title': 'Healthy Eating Tips',
        'content':
            'Eat a variety of foods, including vegetables, fruits, and whole grains.'
      },
      {
        'title': 'Vaccination Guide',
        'content': 'Keep your family up to date with recommended vaccines.'
      },
      {
        'title': 'Mental Health Awareness',
        'content': 'Practice mindfulness and seek help when needed.'
      },
      {
        'title': 'Preventive Healthcare',
        'content': 'Regular checkups and screenings help prevent illness.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Education & Awareness'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Card(
            child: ListTile(
              title: Text(article['title']!),
              subtitle: Text(article['content']!),
              leading: const Icon(Icons.article),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Simulate push notification for public health alert
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Public Health Alert: Stay hydrated during heat waves!')),
          );
        },
        child: const Icon(Icons.notifications_active),
        tooltip: 'Show Health Alert',
      ),
    );
  }
}
