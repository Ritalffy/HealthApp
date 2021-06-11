import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/appointments/bloc/appointment_bloc.dart';

class AppointmentsPage extends StatelessWidget {
  const AppointmentsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Appointments')),
        body: BlocProvider(
          create: (context) => AppointmentBloc(),
          child: Center(
            child: Text('Appointments screen'),
          ),
        ));
  }
}
