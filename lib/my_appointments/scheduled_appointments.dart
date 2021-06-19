import 'package:flutter/material.dart';
import 'package:health_app/widgets/cards/primary_card.dart';

class ScheduledAppointments extends StatelessWidget {
  const ScheduledAppointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryCard(
              isSelected: true,
              buttonLabel: 'Details',
              onPressed: () => print('s'),
              description:
                  'Patient: Adam Adamowski\nJune 16, 2021 03:00 - 03:30 ',
              iconData: Icons.verified_user_sharp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryCard(
              buttonLabel: 'Details',
              onPressed: () => print('s'),
              description:
                  'Patient: Wiktoria Sobczyk\nJune 17, 2021 02:12 - 02:16 ',
              iconData: Icons.verified_user_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
