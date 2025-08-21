
import 'package:flutter/material.dart';
import 'health_models.dart';

class HealthRecordsPage extends StatelessWidget {
  final List<HealthRecord> records;
  final List<ImmunizationReminder> immunizations;
  final List<MedicationReminder> medications;
  final List<DailyHealthLog> dailyLogs;

  const HealthRecordsPage({
    super.key,
    required this.records,
    required this.immunizations,
    required this.medications,
    required this.dailyLogs,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Records & Tracking'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Digital Health Card / Patient ID:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const Card(child: ListTile(title: Text('Patient ID: 1234567890'))),
          const SizedBox(height: 20),
          const Text('Lab Reports & Prescriptions:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...records.map((r) => Card(
                child: ListTile(
                  title: Text(r.type),
                  subtitle: Text(
                      'Date: ${r.date.toLocal().toString().split(' ')[0]}'),
                  trailing: Icon(Icons.picture_as_pdf),
                  onTap: () {
                    // Open file logic
                  },
                ),
              )),
          const SizedBox(height: 20),
          const Text('Immunization Reminders:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...immunizations.map((i) => Card(
                child: ListTile(
                  title: Text(i.vaccine),
                  subtitle: Text(
                      'Due: ${i.dueDate.toLocal().toString().split(' ')[0]}'),
                  trailing: Icon(Icons.vaccines),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Medication Reminders:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...medications.map((m) => Card(
                child: ListTile(
                  title: Text(m.medication),
                  subtitle: Text(
                      'Time: ${m.time.hour}:${m.time.minute.toString().padLeft(2, '0')}'),
                  trailing: Icon(Icons.medication),
                ),
              )),
          const SizedBox(height: 20),
          const Text('Daily Health Logs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...dailyLogs.map((log) => Card(
                child: ListTile(
                  title: Text(
                      'Date: ${log.date.toLocal().toString().split(' ')[0]}'),
                  subtitle: Text(
                      'BP: ${log.bp ?? '-'}, Sugar: ${log.sugar ?? '-'}, Weight: ${log.weight ?? '-'}\nSymptoms: ${log.symptoms ?? 'None'}'),
                  trailing: Icon(Icons.health_and_safety),
                ),
              )),
        ],
      ),
    );
  }
}
