import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/patient_appointments/bloc/appointment_bloc.dart';
import 'package:health_app/patient_appointments/widgets/action_buttons_section.dart';
import 'package:health_app/patient_appointments/widgets/appointment_view.dart';
import 'package:health_app/patient_appointments/widgets/initial_view.dart';
import 'package:health_app/patient_appointments/widgets/select_doctor_view.dart';
import 'package:health_app/patient_appointments/widgets/step_indicator.dart';

class AppointmentFlow extends StatefulWidget {
  List<String> dates = [
    '10:00 AM 05/11',
    '10:30 AM 05/11',
    '11:00 AM 05/11',
    '11:30 AM 05/11',
    '12:00 PM 05/12',
    '12:30 PM 05/12',
    '1:30 PM 05/12',
    '2:00 PM 05/12',
  ];
  AppointmentFlow({Key? key}) : super(key: key);

  @override
  _AppointmentFlowState createState() => _AppointmentFlowState();
}

class _AppointmentFlowState extends State<AppointmentFlow> {
  int currentStep = 1;
  int selectedAppointmentIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: currentStep == 1
          ? const NeverScrollableScrollPhysics()
          : const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 100),
        StapIndicator(currentStep: currentStep),
        const SizedBox(height: 50),
        if (currentStep == 1)
          InitialView()
        else if (currentStep == 2)
          SelectDoctorsView()
        else
          AppointmentsView(
            selectedAppointmentIndex: selectedAppointmentIndex,
            dates: widget.dates,
            onPressed: onSelectButton,
          ),
        const SizedBox(height: 40),
        ActionButtonSection(
          currentStep: currentStep,
          onNextPressed: _onNextPressed,
          onPrevPressed: _onPrevPressed,
        ),
      ],
    );
  }

  void _onNextPressed() {
    if (currentStep == 1) {
      context.read<AppointmentBloc>().add(FetchProfessions());
    }
    if (currentStep == 2) {
      context.read<AppointmentBloc>().add(FetchAppointments());
    }
    setState(() {
      if (currentStep < 3) currentStep++;
    });
  }

  void _onPrevPressed() {
    setState(() {
      currentStep--;
    });
  }

  void onSelectButton(int index) {
    setState(() {
      selectedAppointmentIndex = index;
    });

    context
        .read<AppointmentBloc>()
        .add(AppointmentDateChanged(widget.dates[selectedAppointmentIndex]));
  }
}
