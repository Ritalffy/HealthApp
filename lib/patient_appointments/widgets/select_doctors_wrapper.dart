import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/patient_appointments/bloc/appointment_bloc.dart';
import 'package:health_app/patient_appointments/widgets/profession_dropdown.dart';

class SelectDoctorWrapper extends StatelessWidget {
  const SelectDoctorWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      buildWhen: (previous, current) =>
          previous.avaiableProfessions.length !=
          current.avaiableProfessions.length,
      builder: (context, state) {
        switch (state.professionStatus) {
          case ProfessionStatus.loading:
            return const CircularProgressIndicator.adaptive();

          case ProfessionStatus.error:
            return Text('error occurred');

          case ProfessionStatus.fetched:
            return Container(
                width: double.infinity,
                child: ProfessionDropdown(
                  professions: state.avaiableProfessions,
                ));

          default:
            return Container();
        }
      },
    );
  }
}
