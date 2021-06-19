import 'package:flutter/material.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';

class AppointmentDetailsPageArgs {
  final String patient;
  final String date;
  final String? recommendations;

  const AppointmentDetailsPageArgs({
    required this.patient,
    required this.date,
    required this.recommendations,
  });
}

class AppointmentDetailsPage extends StatelessWidget {
  final AppointmentDetailsPageArgs args;
  AppointmentDetailsPage(this.args);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appoitment details')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Patient: ' + args.patient),
            SizedBox(height: 12),
            Text('Appointment date: ' + args.date),
            SizedBox(height: 12),
            if (args.recommendations != null)
              Text('Recommendations: ${args.recommendations}')
            else
              TextField(
                onChanged: (password) => print(password),
                decoration: InputDecoration(
                  labelText: 'Recommendations',
                ),
              ),
            if (args.recommendations == null)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: PrimaryButton(
                    isSelected: true,
                    label: 'Confirm',
                    onPressed: () {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(
                          const SnackBar(
                              content: Text('Succesful info update')),
                        );
                      Navigator.of(context, rootNavigator: false).pop();
                      Navigator.of(context, rootNavigator: false).pop();
                    }),
              )
          ],
        ),
      ),
    );
  }
}
