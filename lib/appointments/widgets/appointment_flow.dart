import 'package:flutter/material.dart';
import 'package:health_app/appointments/widgets/profession_dropdown.dart';
import 'package:health_app/appointments/widgets/step_indicator.dart';
import 'package:health_app/widgets/primary_button.dart';

// TODO:(Wiktoria) replace mockable flow
// ignore: must_be_immutable
class AppointmentFlow extends StatefulWidget {
  List<String> professions = ['ginekolog', 'kardiolog', 'lekarz ogolny'];
  AppointmentFlow({Key? key}) : super(key: key);

  @override
  _AppointmentFlowState createState() => _AppointmentFlowState();
}

class _AppointmentFlowState extends State<AppointmentFlow> {
  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 100),
        StapIndicator(currentStep: currentStep),
        const SizedBox(height: 50),
        if (currentStep == 1)
          Text(
            'Select doctor\'s profession',
            style: TextStyle(fontSize: 20),
          ),
        const SizedBox(height: 40),
        currentStep == 1
            ? ProfessionDropdown(professions: widget.professions)
            : Container(),
        const SizedBox(height: 40),
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
    );
  }

  void _onNextPressed() {
    setState(() {
      currentStep = 2;
    });
  }

  void _onPrevPressed() {
    setState(() {
      currentStep = 1;
    });
  }
}
