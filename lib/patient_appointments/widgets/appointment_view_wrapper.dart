import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/patient_appointments/bloc/appointment_bloc.dart';
import 'package:health_app/patient_appointments/widgets/appointment_view.dart';

class AppointmentViewWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        switch (state.avaiableAppointmentStatus) {
          case AvaiableAppointmentStatus.loading:
            return Center(child: const CircularProgressIndicator.adaptive());

          case AvaiableAppointmentStatus.error:
            return Text('error occurred');

          case AvaiableAppointmentStatus.fetched:
            return AppointmFentsView(
              appointments: state.avaiableAppointments,
            );

          default:
            return Container();
        }
      },
    );
  }
}
