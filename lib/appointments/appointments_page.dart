import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/appointments/bloc/appointment_bloc.dart';
import 'package:health_app/appointments/widgets/appointment_flow.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({
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
