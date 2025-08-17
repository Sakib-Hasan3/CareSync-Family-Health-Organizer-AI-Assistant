import 'package:flutter/material.dart';

class SymptomCheckerPage extends StatefulWidget {
  const SymptomCheckerPage({super.key});

  @override
  State<SymptomCheckerPage> createState() => _SymptomCheckerPageState();
}

class _SymptomCheckerPageState extends State<SymptomCheckerPage> {
  final TextEditingController controller = TextEditingController();
  String? result;

  void checkSymptoms() {
    // Simple mock logic
    if (controller.text.toLowerCase().contains('fever')) {
      result = 'Possible flu or infection. Please consult a doctor.';
    } else if (controller.text.toLowerCase().contains('headache')) {
      result = 'Possible migraine or dehydration.';
    } else {
      result = 'No specific advice. Please consult a doctor.';
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Symptom Checker'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Describe your symptoms:'),
            TextField(
              controller: controller,
              decoration:
                  const InputDecoration(hintText: 'e.g. fever, headache'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: checkSymptoms,
              child: const Text('Check'),
            ),
            if (result != null) ...[
              const SizedBox(height: 20),
              Text(result!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ],
        ),
      ),
    );
  }
}
