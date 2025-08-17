import 'package:flutter/material.dart';

class Appointment {
  final String doctor;
  final DateTime dateTime;
  final String status; // Booked, Cancelled, Rescheduled

  Appointment(
      {required this.doctor, required this.dateTime, required this.status});
}

class AppointmentsPage extends StatefulWidget {
  final List<Appointment> appointments;
  final List<String> availableDoctors;
  final Map<String, List<DateTime>> clinicSchedules;

  const AppointmentsPage({
    super.key,
    required this.appointments,
    required this.availableDoctors,
    required this.clinicSchedules,
  });

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  String? selectedDoctor;
  DateTime? selectedDateTime;

  void _bookAppointment() {
    if (selectedDoctor != null && selectedDateTime != null) {
      setState(() {
        widget.appointments.add(Appointment(
          doctor: selectedDoctor!,
          dateTime: selectedDateTime!,
          status: 'Booked',
        ));
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Appointment booked!')),
      );
    }
  }

  void _cancelAppointment(int index) {
    setState(() {
      widget.appointments[index] = Appointment(
        doctor: widget.appointments[index].doctor,
        dateTime: widget.appointments[index].dateTime,
        status: 'Cancelled',
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment cancelled.')),
    );
  }

  void _rescheduleAppointment(int index, DateTime newDateTime) {
    setState(() {
      widget.appointments[index] = Appointment(
        doctor: widget.appointments[index].doctor,
        dateTime: newDateTime,
        status: 'Rescheduled',
      );
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Appointment rescheduled.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments & Scheduling'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text('Book Appointment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            hint: const Text('Select Doctor'),
            value: selectedDoctor,
            items: widget.availableDoctors
                .map((doc) => DropdownMenuItem(value: doc, child: Text(doc)))
                .toList(),
            onChanged: (value) {
              setState(() {
                selectedDoctor = value;
                selectedDateTime = null;
              });
            },
          ),
          if (selectedDoctor != null)
            DropdownButton<DateTime>(
              hint: const Text('Select Date & Time'),
              value: selectedDateTime,
              items: widget.clinicSchedules[selectedDoctor]!
                  .map((dt) => DropdownMenuItem(
                      value: dt,
                      child: Text(
                          '${dt.toLocal().toString().split(' ')[0]} ${dt.hour}:${dt.minute.toString().padLeft(2, '0')}')))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedDateTime = value;
                });
              },
            ),
          ElevatedButton(
            onPressed: _bookAppointment,
            child: const Text('Book'),
          ),
          const SizedBox(height: 20),
          const Text('Your Appointments',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...widget.appointments.asMap().entries.map((entry) {
            int idx = entry.key;
            Appointment appt = entry.value;
            return Card(
              child: ListTile(
                title: Text('${appt.doctor}'),
                subtitle: Text(
                    'Date: ${appt.dateTime.toLocal().toString().split(' ')[0]} ${appt.dateTime.hour}:${appt.dateTime.minute.toString().padLeft(2, '0')}\nStatus: ${appt.status}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: appt.status == 'Booked'
                          ? () => _cancelAppointment(idx)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit_calendar),
                      onPressed: appt.status == 'Booked'
                          ? () async {
                              DateTime? newDate = await showDatePicker(
                                context: context,
                                initialDate: appt.dateTime,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now()
                                    .add(const Duration(days: 365)),
                              );
                              if (newDate != null) {
                                TimeOfDay? newTime = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      TimeOfDay.fromDateTime(appt.dateTime),
                                );
                                if (newTime != null) {
                                  DateTime newDateTime = DateTime(
                                    newDate.year,
                                    newDate.month,
                                    newDate.day,
                                    newTime.hour,
                                    newTime.minute,
                                  );
                                  _rescheduleAppointment(idx, newDateTime);
                                }
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
          const Text('Family Calendar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // Simple calendar view (list of appointments)
          ...widget.appointments.map((appt) => ListTile(
                leading: const Icon(Icons.event),
                title: Text('${appt.doctor}'),
                subtitle: Text(
                    '${appt.dateTime.toLocal().toString().split(' ')[0]} ${appt.dateTime.hour}:${appt.dateTime.minute.toString().padLeft(2, '0')}'),
              )),
          const SizedBox(height: 20),
          const Text('Notifications & Reminders',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ...widget.appointments
              .where((a) => a.status == 'Booked')
              .map((appt) => ListTile(
                    leading: const Icon(Icons.notifications_active),
                    title: Text('Upcoming: ${appt.doctor}'),
                    subtitle: Text(
                        '${appt.dateTime.toLocal().toString().split(' ')[0]} ${appt.dateTime.hour}:${appt.dateTime.minute.toString().padLeft(2, '0')}'),
                  )),
        ],
      ),
    );
  }
}
