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
              buttonLabel: 'Schedule',
              description:
                  'Doctor: Andrzej Andrzejowski\n June 17, 2021 02:12 - 02:16 ',
              iconData: Icons.verified_user_sharp,
            ),
          ),
        ],
      ),
    );
  }
}
