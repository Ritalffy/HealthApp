import 'package:flutter/material.dart';
import 'package:health_app/appointments/widgets/step_indicator.dart';
import 'package:health_app/widgets/primary_button.dart';

// TODO:(Wiktoria) replace mockable flow
// ignore: must_be_immutable
class AppointmentFlow extends StatefulWidget {
  List<String> professions = ['ginekolog, kardiolog, lekarz ogolny'];
  AppointmentFlow({Key? key}) : super(key: key);

  @override
  _AppointmentFlowState createState() => _AppointmentFlowState();
}

class _AppointmentFlowState extends State<AppointmentFlow> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StapIndicator(
            currentStep: currentStep,
          ),
          Row(
            children: [
              currentStep != 1
                  ? Expanded(
                      child: PrimaryButton(
                      label: 'Previous',
                      onPressed: _onPrevPressed,
                    ))
                  : Spacer(),
              const SizedBox(width: 24),
              Expanded(
                child: PrimaryButton(
                  label: 'Next',
                  onPressed: _onNextPressed,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _onNextPressed() {
    setState(() {
      currentStep++;
    });
  }

  void _onPrevPressed() {
    setState(() {
      currentStep--;
    });
  }
}
