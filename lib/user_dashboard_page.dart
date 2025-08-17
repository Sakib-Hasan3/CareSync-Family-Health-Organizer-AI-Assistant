import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:ui' as ui; // for ui.ImageFilter

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({super.key});
  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  bool _hasUnread = true;

  // ------------------------------- MOCK DATA ------------------------------
  final List<OverviewStat> _overview = [
    OverviewStat(
      title: 'Average Health Score',
      value: '88%',
      icon: Icons.favorite_rounded,
      sublabel: 'Target: ≥85%  ·  +2%',
      status: StatStatus.good,
    ),
    OverviewStat(
      title: 'Active Medications',
      value: '4',
      icon: Icons.medication_rounded,
      sublabel: 'Total — 0 due',
      status: StatStatus.good,
    ),
    OverviewStat(
      title: 'Pending Appointments',
      value: '7',
      icon: Icons.event_available_rounded,
      sublabel: 'This month  ·  +3',
      status: StatStatus.warning,
    ),
    OverviewStat(
      title: 'Health Alerts',
      value: '3',
      icon: Icons.warning_amber_rounded,
      sublabel: 'Active  ·  −1',
      status: StatStatus.warning,
    ),
  ];

  final List<FamilyMember> _members = [
    FamilyMember(name: 'John Davis', role: 'Parent', initials: 'JD', healthScore: 92, lastCheckup: DateTime(2024, 1, 15), appts: 2, meds: 0, alerts: 1),
    FamilyMember(name: 'Sarah Davis', role: 'Parent', initials: 'SD', healthScore: 88, lastCheckup: DateTime(2024, 1, 10), appts: 2, meds: 0, alerts: 0),
    FamilyMember(name: 'Emma Davis', role: 'Child', initials: 'ED', healthScore: 95, lastCheckup: DateTime(2024, 1, 8), appts: 1, meds: 0, alerts: 0),
    FamilyMember(name: 'Alex Davis', role: 'Child', initials: 'AD', healthScore: 78, lastCheckup: DateTime(2024, 1, 12), appts: 3, meds: 1, alerts: 2),
  ];

  final List<Appointment> _upcoming = [
    Appointment(memberName: 'Sarah Davis', urgency: Urgency.high,   type: 'Cardiology Checkup', provider: 'Dr. Johnson · Today 2:30 PM', dateTime: DateTime.now().add(const Duration(hours: 3))),
    Appointment(memberName: 'Alex Davis',  urgency: Urgency.medium, type: 'Pediatric Visit',     provider: 'Wellness Clinic · Thu 11:00 AM', dateTime: DateTime.now().add(const Duration(days: 2))),
    Appointment(memberName: 'John Davis',  urgency: Urgency.low,    type: 'General Physical',    provider: 'City Hospital · Mon 9:00 AM',    dateTime: DateTime.now().add(const Duration(days: 5))),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final isTablet = width >= 700 && width < 1100;

    return Scaffold(
      appBar: _TopBar(
        hasUnread: _hasUnread,
        onBellTap: () => setState(() => _hasUnread = !_hasUnread),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeroBanner(
              onAddMember: _showAddMember,
              onViewRecords: () => context.go('/records'),
            ),
            const SizedBox(height: 20),
            _Section(
              title: 'Family Health Overview',
              child: _OverviewGrid(
                stats: _overview,
                columns: isMobile ? 1 : isTablet ? 2 : 4,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: isMobile ? 0 : 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Section(
                        title: 'Family Members',
                        trailing: TextButton.icon(
                          onPressed: _showAddMember,
                          icon: const Icon(Icons.add),
                          label: const Text('Add Member'),
                        ),
                        child: _MembersGrid(
                          members: _members,
                          columns: isMobile ? 1 : isTablet ? 3 : 4,
                        ),
                      ),
                      if (isMobile) ...[
                        const SizedBox(height: 16),
                        _QuickActions(),
                        const SizedBox(height: 16),
                        _UpcomingAppointments(list: _upcoming),
                      ],
                    ],
                  ),
                ),
                if (!isMobile) const SizedBox(width: 16),
                if (!isMobile)
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _QuickActions(),
                        const SizedBox(height: 16),
                        _UpcomingAppointments(list: _upcoming),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddMember() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        final nameCtrl = TextEditingController();
        String role = 'Parent';
        return Padding(
          padding: EdgeInsets.only(
            left: 16, right: 16, top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add Family Member', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: 'Full name')),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: 'Parent', child: Text('Parent')),
                  DropdownMenuItem(value: 'Child', child: Text('Child')),
                  DropdownMenuItem(value: 'Guardian', child: Text('Guardian')),
                ],
                onChanged: (v) => role = v ?? 'Parent',
                decoration: const InputDecoration(labelText: 'Role'),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Member "${nameCtrl.text}" added (mock)')),
                  );
                },
                child: const Text('Add Member'),
              )
            ],
          ),
        );
      },
    );
  }
}

// ------------------------------- TOP BAR ----------------------------------
class _TopBar extends StatelessWidget implements PreferredSizeWidget {
  final bool hasUnread; final VoidCallback onBellTap;
  const _TopBar({required this.hasUnread, required this.onBellTap});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 8);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      titleSpacing: 12,
      surfaceTintColor: Colors.transparent,
      title: Row(children: [
        const Icon(Icons.health_and_safety_rounded),
        const SizedBox(width: 8),
        Text('CareSync', style: theme.textTheme.titleMedium),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(children: [
              const Icon(Icons.search, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search health records, appointments…',
                    border: InputBorder.none,
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (q) => ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Search "$q" (mock)'))),
                ),
              ),
            ]),
          ),
        ),
      ]),
      actions: [
        Stack(clipBehavior: Clip.none, children: [
          IconButton(onPressed: onBellTap, icon: const Icon(Icons.notifications_none_rounded)),
          if (hasUnread)
            Positioned(
              right: 10, top: 10,
              child: Container(width: 8, height: 8, decoration: BoxDecoration(color: theme.colorScheme.error, shape: BoxShape.circle)),
            ),
        ]),
        IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () => context.go('/settings')),
        const SizedBox(width: 8),
        CircleAvatar(radius: 16, backgroundColor: theme.colorScheme.primaryContainer, child: const Text('JD', style: TextStyle(fontSize: 12))),
        const SizedBox(width: 12),
      ],
    );
  }
}

// ------------------------------ HERO BANNER --------------------------------
class _HeroBanner extends StatelessWidget {
  final VoidCallback onAddMember; final VoidCallback onViewRecords;
  const _HeroBanner({required this.onAddMember, required this.onViewRecords});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          theme.colorScheme.primaryContainer,
          theme.colorScheme.surfaceContainerHighest,
        ]),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Your Family's Health,\nOrganized & Connected",
            style: theme.textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Text(
          "Bring your family's health information together. Track appointments, medications and records for everyone you care about.",
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Wrap(spacing: 12, runSpacing: 8, children: [
          FilledButton.icon(onPressed: onAddMember, icon: const Icon(Icons.person_add_alt_1), label: const Text('Add Family Member')),
          OutlinedButton(onPressed: onViewRecords, child: const Text('View All Records')),
        ]),
      ]),
    );
  }
}

// ------------------------------ SECTION WRAP ------------------------------
class _Section extends StatelessWidget {
  final String title; final Widget child; final Widget? trailing;
  const _Section({required this.title, required this.child, this.trailing});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, style: theme.textTheme.titleLarge),
        if (trailing != null) trailing!,
      ]),
      const SizedBox(height: 12),
      child,
    ]);
  }
}

// ----------------------------- OVERVIEW GRID ------------------------------
class _OverviewGrid extends StatelessWidget {
  final List<OverviewStat> stats; final int columns;
  const _OverviewGrid({required this.stats, required this.columns});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 2.6,
      ),
      itemCount: stats.length,
      itemBuilder: (context, i) => StatCard(stat: stats[i]),
    );
  }
}

class StatCard extends StatelessWidget {
  final OverviewStat stat; const StatCard({super.key, required this.stat});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color container;
    switch (stat.status) {
      case StatStatus.good:    container = theme.colorScheme.primaryContainer;  break;
      case StatStatus.warning: container = theme.colorScheme.tertiaryContainer; break;
      case StatStatus.danger:  container = theme.colorScheme.errorContainer;    break;
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: container.withValues(alpha: 0.55), // instead of withOpacity
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: container.withValues(alpha: 0.13),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.12),
              width: 1.2,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Icon(stat.icon, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(stat.title, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          stat.value,
                          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(width: 8),
                        StatusChip(status: stat.status),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(stat.sublabel, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatusChip extends StatelessWidget {
  final StatStatus status; const StatusChip({super.key, required this.status});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late final String label; late final Color bg;
    switch (status) {
      case StatStatus.good:    label = 'good';    bg = theme.colorScheme.primaryContainer;  break;
      case StatStatus.warning: label = 'warning'; bg = theme.colorScheme.tertiaryContainer; break;
      case StatStatus.danger:  label = 'danger';  bg = theme.colorScheme.errorContainer;    break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}

// ------------------------------ MEMBERS GRID ------------------------------
class _MembersGrid extends StatelessWidget {
  final List<FamilyMember> members; final int columns;
  const _MembersGrid({required this.members, required this.columns});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.28,
      ),
      itemCount: members.length,
      itemBuilder: (context, i) => MemberCard(member: members[i]),
    );
  }
}

class MemberCard extends StatelessWidget {
  final FamilyMember member; const MemberCard({super.key, required this.member});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color scoreColor(FamilyMember m) {
      if (m.healthScore >= 90) return theme.colorScheme.primaryContainer;
      if (m.healthScore >= 80) return theme.colorScheme.tertiaryContainer;
      return theme.colorScheme.errorContainer;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withValues(alpha: 0.10),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.10),
              width: 1.1,
            ),
          ),
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              CircleAvatar(backgroundColor: theme.colorScheme.primary, child: const Text('')),
              CircleAvatar(backgroundColor: theme.colorScheme.primary, child: Text(member.initials, style: const TextStyle(color: Colors.white))),
              const SizedBox(width: 12),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(member.name, style: theme.textTheme.titleMedium),
                Row(children: [
                  Icon(
                    member.role == 'Parent' ? Icons.person : member.role == 'Child' ? Icons.child_care : Icons.shield,
                    size: 16, color: theme.colorScheme.secondary,
                  ),
                  const SizedBox(width: 4),
                  Text(member.role, style: theme.textTheme.bodySmall),
                ]),
              ]),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: scoreColor(member), borderRadius: BorderRadius.circular(20)),
                child: Text('${member.healthScore}%', style: theme.textTheme.labelSmall),
              ),
              const SizedBox(width: 6),
              Text('Health Score', style: theme.textTheme.bodySmall),
            ]),
            const SizedBox(height: 8),
            Row(children: [
              const _MiniStat(icon: Icons.event_available, label: 'Appts'),
              Text(' ${member.appts}  '),
              const _MiniStat(icon: Icons.medication, label: 'Meds'),
              Text(' ${member.meds}  '),
              const _MiniStat(icon: Icons.warning_amber_rounded, label: 'Alerts'),
              Text(' ${member.alerts}'),
            ]),
            const Spacer(),
            Text('Last checkup: ${_fmtDate(member.lastCheckup)}', style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: theme.colorScheme.primary,
                  side: BorderSide(color: theme.colorScheme.primary),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Viewing ${member.name} profile (mock)')),
                  );
                  context.go('/profile');
                },
                child: const Text('View Profile'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final IconData icon; final String label;
  const _MiniStat({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Icon(icon, size: 16),
      const SizedBox(width: 4),
      Text(label, style: Theme.of(context).textTheme.labelSmall),
      const SizedBox(width: 8),
    ]);
  }
}

String _fmtDate(DateTime d) =>
    '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

// -------------------------- QUICK ACTIONS & UPCOMING ----------------------
class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Quick Actions', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
      const SizedBox(height: 16),
      _PastelActionCard(
        color: const Color(0xFFE6F2FF),
        icon: Icons.event_available,
        iconColor: Colors.blue,
        title: 'Schedule Appointment',
        subtitle: 'Book medical appointments for family members',
        onTap: () => context.go('/appointments'),
      ),
      const SizedBox(height: 14),
      _PastelActionCard(
        color: const Color(0xFFF0FFF7),
        icon: Icons.person_add_alt_1,
        iconColor: Colors.teal,
        title: 'Add Family Member',
        subtitle: 'Invite new family member to CareSync',
        onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add member (mock)'))),
      ),
    ]);
  }
}

class _PastelActionCard extends StatelessWidget {
  final Color color; final IconData icon; final Color iconColor;
  final String title; final String subtitle; final VoidCallback onTap;
  const _PastelActionCard({
    required this.color, required this.icon, required this.iconColor,
    required this.title, required this.subtitle, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(color: color.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: iconColor, size: 28),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingAppointments extends StatelessWidget {
  final List<Appointment> list; const _UpcomingAppointments({required this.list});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Upcoming Appointments', style: theme.textTheme.titleLarge),
      const SizedBox(height: 12),
      if (list.isEmpty)
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text('No appointments scheduled.'),
        )
      else
        ListView.separated(
          itemCount: list.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) => AppointmentCard(appt: list[i]),
        ),
    ]);
  }
}

class AppointmentCard extends StatelessWidget {
  final Appointment appt; const AppointmentCard({super.key, required this.appt});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Color bg;
    switch (appt.urgency) {
      case Urgency.high:   bg = theme.colorScheme.errorContainer;    break;
      case Urgency.medium: bg = theme.colorScheme.tertiaryContainer; break;
      case Urgency.low:    bg = theme.colorScheme.surfaceContainerHighest; break;
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            color: bg.withValues(alpha: 0.70),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: bg.withValues(alpha: 0.13), blurRadius: 10, offset: const Offset(0, 6)),
            ],
            border: Border.all(color: Colors.white.withValues(alpha: 0.10), width: 1.1),
          ),
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  _Chip(text: appt.memberName),
                  const SizedBox(width: 8),
                  _Chip(text: appt.urgency.name, icon: CupertinoIcons.flag),
                ]),
                const SizedBox(height: 8),
                Text(appt.type, style: Theme.of(context).textTheme.titleMedium),
                Text(appt.provider, style: Theme.of(context).textTheme.bodySmall),
              ]),
              const Spacer(),
              Wrap(spacing: 8, children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: theme.colorScheme.primary,
                    side: BorderSide(color: theme.colorScheme.primary),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => context.go('/appointments'),
                  child: const Text('Reschedule'),
                ),
                FilledButton.tonal(
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () => context.go('/appointments'),
                  child: const Text('View Details'),
                ),
              ])
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String text; final IconData? icon;
  const _Chip({required this.text, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (icon != null) ...[Icon(icon, size: 14), const SizedBox(width: 4)],
        Text(text, style: Theme.of(context).textTheme.labelSmall),
      ]),
    );
  }
}

// --------------------------------- MODELS ---------------------------------
class OverviewStat {
  final String title; final String value; final IconData icon; final String sublabel; final StatStatus status;
  OverviewStat({required this.title, required this.value, required this.icon, required this.sublabel, required this.status});
}
enum StatStatus { good, warning, danger }

enum Urgency { high, medium, low }

class FamilyMember {
  final String name; final String role; final String initials; final int healthScore;
  final DateTime lastCheckup; final int appts; final int meds; final int alerts;
  FamilyMember({required this.name, required this.role, required this.initials, required this.healthScore, required this.lastCheckup, required this.appts, required this.meds, required this.alerts});
}

class Appointment {
  final String memberName; final Urgency urgency; final String type; final String provider; final DateTime dateTime; final String status;
  Appointment({required this.memberName, required this.urgency, required this.type, required this.provider, required this.dateTime, this.status = 'scheduled'});
}
