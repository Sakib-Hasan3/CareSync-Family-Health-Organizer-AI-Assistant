import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'index.dart'; // <- the landing page above
import 'login_page.dart';
import 'register_page.dart';
import 'user_dashboard_page.dart';
import 'appointments_page.dart' as appt_page;
import 'profile_page.dart';
import 'health_records_page.dart';
import 'telehealth_page.dart';
import 'chat_page.dart';
import 'payments_page.dart';
import 'emergency_page.dart';
import 'health_education_page.dart';
import 'symptom_checker_page.dart';
import 'wellness_page.dart';
import 'models.dart' as models;

/// ---------- Simple auth state ----------
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

/// ---------- Router ----------
final GoRouter _router = GoRouter(
  initialLocation: '/',                 // <- start at IndexPage
  refreshListenable: authState,
  routes: [
    GoRoute(path: '/', builder: (_, __) => const IndexPage()),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginPage(),
      redirect: (_, __) => authState.isLoggedIn ? '/user-dashboard' : null,
    ),
    GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
    GoRoute(
      path: '/user-dashboard',
      builder: (_, __) => const UserDashboardPage(),
      redirect: (_, __) => authState.isLoggedIn ? null : '/login',
      routes: [
        GoRoute(
          path: 'appointments',
          builder: (_, __) => appt_page.AppointmentsPage(
            appointments: const [],
            availableDoctors: const [],
            clinicSchedules: const {},
          ),
        ),
        GoRoute(
          path: 'profile',
          builder: (_, __) => ProfilePage(
            user: models.UserProfile(
              name: 'Demo',
              email: 'demo@demo.com',
              familyMembers: const [],
            ),
          ),
        ),
        GoRoute(
          path: 'records',
          builder: (_, __) => const HealthRecordsPage(
            records: [],
            immunizations: [],
            medications: [],
            dailyLogs: [],
          ),
        ),
        GoRoute(path: 'telehealth', builder: (_, __) => const TelehealthPage()),
        GoRoute(path: 'chat', builder: (_, __) => const ChatPage()),
        GoRoute(path: 'payments', builder: (_, __) => const PaymentsPage()),
        GoRoute(path: 'emergency', builder: (_, __) => const EmergencyPage()),
        GoRoute(path: 'education', builder: (_, __) => const HealthEducationPage()),
        GoRoute(path: 'symptoms', builder: (_, __) => const SymptomCheckerPage()),
        GoRoute(path: 'wellness', builder: (_, __) => const WellnessPage()),
      ],
    ),
  ],
);

void main() => runApp(const FamilyHealthApp());

class FamilyHealthApp extends StatelessWidget {
  const FamilyHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Family Health Organization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF1FC6A6),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}
