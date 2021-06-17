import 'package:flutter/material.dart';
import 'package:health_app/patient_appointments/widgets/select_doctors_wrapper.dart';

class SelectDoctorsView extends StatelessWidget {
  final List<String> professions;
  const SelectDoctorsView({
    required this.professions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select doctor\'s profession',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 40),
        SelectDoctorWrapper(),
      ],
    );
  }
}
