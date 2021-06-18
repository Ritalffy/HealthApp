import 'package:flutter/material.dart';

class ScheduledAppointments extends StatelessWidget {
  const ScheduledAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: ListView(
        children: [
          Text('Scheduled appointments'),
        ],
      ),
    );
  }
}
