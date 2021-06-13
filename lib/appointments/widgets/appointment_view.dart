import 'package:flutter/material.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';

typedef IntCallback = void Function(int);

class AppointmentsView extends StatelessWidget {
  final List<String> dates;
  final IntCallback onPressed;
  final int selectedAppointmentIndex;
  const AppointmentsView({
    required this.dates,
    required this.onPressed,
    required this.selectedAppointmentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Select appointment slot',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 40),
        ListView.separated(
          itemCount: dates.length,
          physics: const NeverScrollableScrollPhysics(),
          clipBehavior: Clip.none,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return PrimaryButton(
              isSelected: selectedAppointmentIndex == index,
              label: dates[index],
              onPressed: () => onPressed(index),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: 12),
        ),
      ],
    );
  }
}
