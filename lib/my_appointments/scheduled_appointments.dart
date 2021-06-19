import 'package:flutter/material.dart';
import 'package:health_app/appointment_details/appointment_details.dart';
import 'package:health_app/utils/navigation/dashboard_routes.dart';
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
              onPressed: () => Navigator.of(context, rootNavigator: false)
                  .pushNamed<void>(DashboardRoutes.patientAppointmentsDetails,
                      arguments: AppointmentDetailsPageArgs(
                        date: 'June 16, 2021 03:00 - 03:30',
                        patient: 'Adam Adamowski',
                        recommendations: 'paracetamol 3x a day',
                      )),
              description:
                  'Patient: Adam Adamowski\nJune 16, 2021 03:00 - 03:30 ',
              iconData: Icons.verified_user_sharp,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PrimaryCard(
              buttonLabel: 'Details',
              onPressed: () => Navigator.of(context, rootNavigator: false)
                  .pushNamed<void>(DashboardRoutes.patientAppointmentsDetails,
                      arguments: AppointmentDetailsPageArgs(
                        date: 'June 17, 2021 02:12 - 02:16',
                        patient: 'Wiktoria Sobczyk',
                        recommendations: null,
                      )),
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
