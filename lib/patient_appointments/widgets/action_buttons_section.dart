import 'package:flutter/material.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';

class ActionButtonSection extends StatelessWidget {
  final int currentStep;
  final VoidCallback onPrevPressed;
  final VoidCallback onNextPressed;
  const ActionButtonSection({
    required this.currentStep,
    required this.onNextPressed,
    required this.onPrevPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        currentStep != 1
            ? Expanded(
                child: PrimaryButton(
                label: 'Previous',
                onPressed: onPrevPressed,
              ))
            : Spacer(),
        const SizedBox(width: 24),
        Expanded(
          child: PrimaryButton(
            isSelected: currentStep == 3,
            label: currentStep != 3 ? 'Next' : 'Submit',
            onPressed: onNextPressed,
          ),
        )
      ],
    );
  }
}
