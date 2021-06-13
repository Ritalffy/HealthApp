import 'package:flutter/material.dart';
import 'package:health_app/appointments/widgets/profession_dropdown.dart';

class SelectDoctorsView extends StatelessWidget {
  final List<String> professions;
  const SelectDoctorsView({
    required this.professions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select doctor\'s profession',
          style: TextStyle(fontSize: 20),
        ),
        ProfessionDropdown(professions: professions),
      ],
    );
  }
}