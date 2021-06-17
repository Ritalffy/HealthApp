import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/patient_appointments/bloc/appointment_bloc.dart';
import 'package:health_app/patient_appointments/widgets/appointment_flow.dart';

class PatientAppointmentsPage extends StatelessWidget {
  const PatientAppointmentsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: BlocProvider(
        create: (context) => AppointmentBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context)),
        child: AppointmentFlow(),
      ),
    );
  }
}
