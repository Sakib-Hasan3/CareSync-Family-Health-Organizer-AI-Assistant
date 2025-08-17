import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'register_page.dart';
import 'profile_page.dart';
import 'health_records_page.dart';
import 'appointments_page.dart' as appt_page;
import 'models.dart' as models;
import 'health_models.dart' as health_models;
import 'user_dashboard_page.dart';
import 'telehealth_page.dart';
import 'chat_page.dart';
import 'payments_page.dart';
import 'emergency_page.dart';
import 'health_education_page.dart';
import 'symptom_checker_page.dart';
import 'wellness_page.dart';

class AuthState extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    notifyListeners();
  }
}

final authState = AuthState();

final GoRouter _router = GoRouter(
  refreshListenable: authState,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(),
      redirect: (context, state) =>
          authState.isLoggedIn ? '/user-dashboard' : null,
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterPage(),
    ),
    GoRoute(
      path: '/user-dashboard',
      builder: (context, state) => UserDashboardPage(),
      redirect: (context, state) => authState.isLoggedIn ? null : '/login',
      routes: [
        GoRoute(
          path: 'appointments',
          builder: (context, state) => appt_page.AppointmentsPage(
              appointments: [], availableDoctors: [], clinicSchedules: {}),
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) => ProfilePage(
            user: models.UserProfile(
                name: 'Demo', email: 'demo@demo.com', familyMembers: []),
          ),
        ),
        GoRoute(
          path: 'records',
          builder: (context, state) => HealthRecordsPage(
            records: [],
            immunizations: [],
            medications: [],
            dailyLogs: [],
          ),
        ),
        GoRoute(
          path: 'telehealth',
          builder: (context, state) => TelehealthPage(),
        ),
        GoRoute(
          path: 'chat',
          builder: (context, state) => ChatPage(),
        ),
        GoRoute(
          path: 'payments',
          builder: (context, state) => PaymentsPage(),
        ),
        GoRoute(
          path: 'emergency',
          builder: (context, state) => EmergencyPage(),
        ),
        GoRoute(
          path: 'education',
          builder: (context, state) => HealthEducationPage(),
        ),
        GoRoute(
          path: 'symptoms',
          builder: (context, state) => SymptomCheckerPage(),
        ),
        GoRoute(
          path: 'wellness',
          builder: (context, state) => WellnessPage(),
        ),
      ],
    ),
  ],
);

void main() {
  runApp(FamilyHealthApp());
}

class FamilyHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Family Health Organization',
      theme: ThemeData(primarySwatch: Colors.teal),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Health Organization'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.family_restroom, size: 100, color: Colors.teal),
            const SizedBox(height: 30),
            const Text(
              'Welcome to Family Health Organization',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'Your health, our priority.',
              style: TextStyle(fontSize: 18, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example user data
                final user = models.UserProfile(
                  name: 'John Doe',
                  email: 'john@example.com',
                  familyMembers: [
                    models.FamilyMember(
                      id: '1',
                      name: 'Jane Doe',
                      role: 'Wife',
                      avatarInitials: 'JD',
                      healthScore: 85,
                      lastCheckup: '2025-07-01',
                      apptCount: 2,
                      medCount: 1,
                      alertCount: 0,
                      age: 35,
                      relationLegacy: 'Wife',
                      medicalHistory: ['Diabetes'],
                      vaccinationRecords: ['COVID-19', 'Flu'],
                      emergencyContact: '123-456-7890',
                    ),
                    models.FamilyMember(
                      id: '2',
                      name: 'Sam Doe',
                      role: 'Son',
                      avatarInitials: 'SD',
                      healthScore: 90,
                      lastCheckup: '2025-07-10',
                      apptCount: 1,
                      medCount: 0,
                      alertCount: 0,
                      age: 10,
                      relationLegacy: 'Son',
                      medicalHistory: ['Asthma'],
                      vaccinationRecords: ['MMR', 'Polio'],
                      emergencyContact: '123-456-7890',
                    ),
                  ],
                );
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(user: user),
                  ),
                );
              },
              child: const Text('View Profile'),
            ),
            ElevatedButton(
              onPressed: () {
                // Example health data
                final records = [
                  health_models.HealthRecord(
                      id: '1',
                      type: 'Lab Report',
                      fileUrl: '',
                      date: DateTime.now().subtract(const Duration(days: 10))),
                  health_models.HealthRecord(
                      id: '2',
                      type: 'Prescription',
                      fileUrl: '',
                      date: DateTime.now().subtract(const Duration(days: 5))),
                ];
                final immunizations = [
                  health_models.ImmunizationReminder(
                      vaccine: 'COVID-19',
                      dueDate: DateTime.now().add(const Duration(days: 30))),
                ];
                final medications = [
                  health_models.MedicationReminder(
                      medication: 'Metformin',
                      time: DateTime.now().add(const Duration(hours: 2))),
                ];
                final dailyLogs = [
                  health_models.DailyHealthLog(
                      date: DateTime.now(),
                      bp: 120,
                      sugar: 90,
                      weight: 70,
                      symptoms: 'None'),
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HealthRecordsPage(
                      records: records,
                      immunizations: immunizations,
                      medications: medications,
                      dailyLogs: dailyLogs,
                    ),
                  ),
                );
              },
              child: const Text('Health Records & Tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                // Example appointment data
                final appointments = [
                  appt_page.Appointment(
                    doctor: 'Dr. Smith',
                    dateTime:
                        DateTime.now().add(const Duration(days: 2, hours: 10)),
                    status: 'Booked',
                  ),
                  appt_page.Appointment(
                    doctor: 'Dr. Lee',
                    dateTime:
                        DateTime.now().add(const Duration(days: 5, hours: 14)),
                    status: 'Booked',
                  ),
                ];
                final availableDoctors = ['Dr. Smith', 'Dr. Lee', 'Dr. Patel'];
                final clinicSchedules = {
                  'Dr. Smith': [
                    DateTime.now().add(const Duration(days: 2, hours: 10)),
                    DateTime.now().add(const Duration(days: 3, hours: 11)),
                  ],
                  'Dr. Lee': [
                    DateTime.now().add(const Duration(days: 5, hours: 14)),
                    DateTime.now().add(const Duration(days: 6, hours: 9)),
                  ],
                  'Dr. Patel': [
                    DateTime.now().add(const Duration(days: 7, hours: 13)),
                  ],
                };
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => appt_page.AppointmentsPage(
                      appointments: appointments,
                      availableDoctors: availableDoctors,
                      clinicSchedules: clinicSchedules,
                    ),
                  ),
                );
              },
              child: const Text('Appointments & Scheduling'),
            ),
            ElevatedButton(
              onPressed: () {
                // Example family member data
                final familyMembers = [
                  FamilyMember(
                    name: 'Jane Doe',
                    role: 'Wife',
                    initials: 'JD',
                    healthScore: 85,
                    lastCheckup: DateTime(2025, 7, 1),
                    appts: 2,
                    meds: 1,
                    alerts: 0,
                  ),
                  FamilyMember(
                    name: 'Sam Doe',
                    role: 'Son',
                    initials: 'SD',
                    healthScore: 90,
                    lastCheckup: DateTime(2025, 7, 10),
                    appts: 1,
                    meds: 0,
                    alerts: 0,
                  ),
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FamilyProfilesPage(members: familyMembers),
                  ),
                );
              },
              child: const Text('Family Profiles'),
            ),
            ElevatedButton(
              onPressed: () {
                // Example reminders data
                final reminders = [
                  'COVID-19 Vaccine - Due on ${DateTime.now().add(const Duration(days: 30)).toLocal()}',
                  'Metformin - Take 1 tablet at ${DateTime.now().add(const Duration(hours: 2)).toLocal()}',
                ];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RemindersPage(reminders: reminders),
                  ),
                );
              },
              child: const Text('Vaccination & Medication Reminders'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelfTrackingPage(),
                  ),
                );
              },
              child: const Text('Self-Tracking'),
            ),
            ElevatedButton(
              onPressed: () {
                // Example user ID
                final userId = 'USER123456';
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DigitalHealthCardPage(userId: userId),
                  ),
                );
              },
              child: const Text('Digital Health Card'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? error;

  void _login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      authState.login();
      context.go('/user-dashboard');
    } else {
      setState(() {
        error = 'Please enter both email and password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Text(error!, style: const TextStyle(color: Colors.red)),
            ],
            TextButton(
              onPressed: () {
                context.go('/register');
              },
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}

class FamilyProfilesPage extends StatelessWidget {
  final List<FamilyMember> members;
  const FamilyProfilesPage({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Profiles'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: members.length,
        itemBuilder: (context, index) {
          final member = members[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(member.initials)),
              title: Text(member.name),
              subtitle: Text(
                  'Role: ${member.role}\nHealth Score: ${member.healthScore}%'),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  // Implement edit functionality
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement add family member functionality
        },
        child: const Icon(Icons.add),
        tooltip: 'Add Family Member',
      ),
    );
  }
}

class MedicalHistoryPage extends StatelessWidget {
  final List<String> history;
  const MedicalHistoryPage({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical History'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.history),
              title: Text(history[index]),
            ),
          );
        },
      ),
    );
  }
}

class RemindersPage extends StatelessWidget {
  final List<String> reminders;
  const RemindersPage({super.key, required this.reminders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccination & Medication Reminders'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: reminders.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const Icon(Icons.vaccines),
              title: Text(reminders[index]),
              trailing: IconButton(
                icon: const Icon(Icons.notifications_active),
                onPressed: () {
                  // Simulate sending a notification
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Reminder sent: ${reminders[index]}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class SelfTrackingPage extends StatefulWidget {
  const SelfTrackingPage({super.key});

  @override
  State<SelfTrackingPage> createState() => _SelfTrackingPageState();
}

class _SelfTrackingPageState extends State<SelfTrackingPage> {
  final TextEditingController bpController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController symptomsController = TextEditingController();
  final List<String> logs = [];

  void _addLog() {
    final log =
        'BP: ${bpController.text}, Glucose: ${glucoseController.text}, Weight: ${weightController.text}, Symptoms: ${symptomsController.text}';
    setState(() {
      logs.add(log);
      bpController.clear();
      glucoseController.clear();
      weightController.clear();
      symptomsController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Self-Tracking'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: bpController,
              decoration: const InputDecoration(labelText: 'Blood Pressure'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: glucoseController,
              decoration: const InputDecoration(labelText: 'Glucose'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: weightController,
              decoration: const InputDecoration(labelText: 'Weight'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: symptomsController,
              decoration: const InputDecoration(labelText: 'Symptoms'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addLog,
              child: const Text('Add Log'),
            ),
            const SizedBox(height: 20),
            const Text('Logs:', style: TextStyle(fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(logs[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DigitalHealthCardPage extends StatelessWidget {
  final String userId;
  const DigitalHealthCardPage({Key? key, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Health Card'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Scan this QR code at clinics'),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 200,
              child: QrImageView(
                data: userId,
              ),
            ),
            const SizedBox(height: 20),
            Text('User ID: $userId'),
          ],
        ),
      ),
    );
  }
}
