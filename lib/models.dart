class FamilyMember {
  final String id;
  final String name;
  final String role;
  final String avatarInitials;
  final int healthScore;
  final String lastCheckup;
  final int apptCount;
  final int medCount;
  final int alertCount;

  // For legacy compatibility
  final int? age;
  final String? relationLegacy;
  final List<String>? medicalHistory;
  final List<String>? vaccinationRecords;
  final String? emergencyContact;

  FamilyMember({
    required this.id,
    required this.name,
    required this.role,
    required this.avatarInitials,
    required this.healthScore,
    required this.lastCheckup,
    required this.apptCount,
    required this.medCount,
    required this.alertCount,
    this.age,
    this.relationLegacy,
    this.medicalHistory,
    this.vaccinationRecords,
    this.emergencyContact,
  });
}

class UserProfile {
  final String name;
  final String email;
  final List<FamilyMember> familyMembers;

  UserProfile({
    required this.name,
    required this.email,
    required this.familyMembers,
  });
}
