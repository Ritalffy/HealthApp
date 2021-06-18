import 'package:authentication_repository/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:health_app/patient_appointments/bloc/appointment_bloc.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef IntCallback = void Function(int);

class AppointmentsView extends StatefulWidget {
  final List<PatientAppointment> appointments;

  const AppointmentsView({
    required this.appointments,
  });

  @override
  _AppointmentsViewState createState() => _AppointmentsViewState();
}

class _AppointmentsViewState extends State<AppointmentsView> {
  int selectedAppointmentIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select appointment slot',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 40),
        ListView.separated(
          itemCount: widget.appointments.length,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return PrimaryButton(
              isSelected: selectedAppointmentIndex == index,
              label: widget.appointments[index].doctorName,
              onPressed: () => onSelectButton(index),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 12),
        ),
      ],
    );
  }

  void onSelectButton(int index) {
    setState(() {
      selectedAppointmentIndex = index;
    });

    context.read<AppointmentBloc>().add(
        AppointmentDateChanged(widget.appointments[selectedAppointmentIndex]));
  }
}
