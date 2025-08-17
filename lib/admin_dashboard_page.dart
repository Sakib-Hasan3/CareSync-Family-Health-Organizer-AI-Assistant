import 'package:flutter/material.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final patients = [
      {'name': 'John Doe', 'status': 'Active'},
      {'name': 'Jane Smith', 'status': 'Inactive'},
    ];
    final appointments = [
      {
        'patient': 'John Doe',
        'doctor': 'Dr. Smith',
        'time': '2025-08-20 10:00'
      },
      {
        'patient': 'Jane Smith',
        'doctor': 'Dr. Lee',
        'time': '2025-08-21 14:00'
      },
    ];
    final staff = [
      {'name': 'Nurse Joy', 'duty': 'Morning'},
      {'name': 'Dr. Smith', 'duty': 'Evening'},
    ];
    final analytics = {
      'Total Patients': 120,
      'Appointments This Month': 45,
      'Staff On Duty': 8,
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin & Staff Dashboard'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Patient Management',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...patients.map((p) => Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(p['name'].toString()),
                  subtitle: Text('Status: ${p['status']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {},
                  ),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Appointment & Resource Scheduling',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...appointments.map((a) => Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text('${a['patient']} with ${a['doctor']}'),
                  subtitle: Text('Time: ${a['time']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel),
                    onPressed: () {},
                  ),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Analytics & Reporting',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...analytics.entries.map((entry) => ListTile(
                leading: const Icon(Icons.bar_chart),
                title: Text(entry.key),
                trailing: Text(entry.value.toString()),
              )),
          const SizedBox(height: 20),
          const Text('Staff Communication & Duty Rosters',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...staff.map((s) => Card(
                child: ListTile(
                  leading: const Icon(Icons.medical_services),
                  title: Text(s['name'].toString()),
                  subtitle: Text('Duty: ${s['duty']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.message),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Message to ${s['name']} coming soon!')),
                      );
                    },
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
