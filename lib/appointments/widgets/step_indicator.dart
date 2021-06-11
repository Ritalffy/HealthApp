import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StapIndicator extends StatelessWidget {
  final int currentStep;

  const StapIndicator({required this.currentStep})
      : assert(currentStep >= 1 && currentStep <= 2,
            'current step must be in compartment');

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: 2,
      currentStep: currentStep,
      size: 10,
      selectedColor: Colors.blueAccent,
      unselectedColor: Color.fromRGBO(240, 240, 240, 1),
      roundedEdges: Radius.circular(10),
    );
  }
}
