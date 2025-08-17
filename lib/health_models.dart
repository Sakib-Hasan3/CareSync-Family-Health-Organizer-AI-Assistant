class Appointment {
  final String id;
  final String memberName;
  final String urgency;
  final String type;
  final String provider;
  final DateTime dateTime;
  final String status;

  Appointment({
    required this.id,
    required this.memberName,
    required this.urgency,
    required this.type,
    required this.provider,
    required this.dateTime,
    required this.status,
  });
}

class HealthRecord {
  final String id;
  final String type; // e.g. 'Lab Report', 'Prescription'
  final String fileUrl; // For uploaded files
  final DateTime date;

  HealthRecord({
    required this.id,
    required this.type,
    required this.fileUrl,
    required this.date,
  });
}

class ImmunizationReminder {
  final String vaccine;
  final DateTime dueDate;

  ImmunizationReminder({
    required this.vaccine,
    required this.dueDate,
  });
}

class MedicationReminder {
  final String medication;
  final DateTime time;

  MedicationReminder({
    required this.medication,
    required this.time,
  });
}

class DailyHealthLog {
  final DateTime date;
  final double? bp;
  final double? sugar;
  final double? weight;
  final String? symptoms;

  DailyHealthLog({
    required this.date,
    this.bp,
    this.sugar,
    this.weight,
    this.symptoms,
  });
}
