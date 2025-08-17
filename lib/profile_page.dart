import 'package:flutter/material.dart';
import 'models.dart';

class ProfilePage extends StatelessWidget {
  final UserProfile user;
  const ProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text('Name: ${user.name}', style: const TextStyle(fontSize: 18)),
            Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            const Text('Family Members:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ...user.familyMembers.map((member) => Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${member.name}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('Age: ${member.age}'),
                        Text(
                            'Relation: ${member.relationLegacy ?? member.role}'),
                        const SizedBox(height: 8),
                        Text(
                            'Medical History: ${member.medicalHistory?.join(", ") ?? "None"}'),
                        Text(
                            'Vaccination Records: ${member.vaccinationRecords?.join(", ") ?? "None"}'),
                        Text('Emergency Contact: ${member.emergencyContact}'),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
