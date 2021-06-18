import 'package:authentication_repository/models/appointment.dart';
import 'package:flutter/material.dart';
import 'package:health_app/patient_appointments/bloc/appointment_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/widgets/cards/primary_card.dart';
import 'package:intl/intl.dart';

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
            final appointment = widget.appointments[index];
            return GestureDetector(
              onTap: () => onSelectButton(index),
              child: PrimaryCard(
                isSelected: selectedAppointmentIndex == index,
                buttonLabel: 'Schedule',
                description:
                    'Doctor: ${appointment.doctorName}\n${_startFormatter(appointment.start)} - ${_endFormatter(appointment.end)} ',
                iconData: Icons.verified_user_sharp,
              ),
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

  String _startFormatter(DateTime date) {
    final dateFormat = DateFormat('MMMM d, yyyy HH:mm');
    return dateFormat.format(date);
  }

  String _endFormatter(DateTime date) {
    final dateFormat = DateFormat('HH:mm');
    return dateFormat.format(date);
  }
}
