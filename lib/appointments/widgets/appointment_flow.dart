import 'package:flutter/material.dart';
import 'package:health_app/appointments/widgets/profession_dropdown.dart';
import 'package:health_app/appointments/widgets/step_indicator.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';

// TODO:(Wiktoria) replace mockable flow
// ignore: must_be_immutable
class AppointmentFlow extends StatefulWidget {
  List<String> professions = ['gynecologist', 'cardiologist', 'general doctor'];
  Map<String, bool> dates = {
    '10:00 AM 05/11': false,
    '10:30 AM 05/11': false,
    '11:00 AM 05/11': false,
    '11:30 AM 05/11': false,
    '12:00 PM 05/12': false,
    '12:30 PM 05/12': false,
    '1:30 PM 05/12': false,
    '2:00 PM 05/12': false,
  };
  AppointmentFlow({Key? key}) : super(key: key);

  @override
  _AppointmentFlowState createState() => _AppointmentFlowState();
}

class _AppointmentFlowState extends State<AppointmentFlow> {
  int currentStep = 1;

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
        Text(
          currentStep == 1
              ? 'Select doctor\'s profession'
              : 'Select appointment slot',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 40),
        currentStep == 1
            ? ProfessionDropdown(professions: widget.professions)
            : ListView.separated(
                itemCount: widget.dates.length,
                physics: const NeverScrollableScrollPhysics(),
                clipBehavior: Clip.none,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final keys = widget.dates.keys.toList();
                  return PrimaryButton(
                    isSelected: widget.dates[keys[index]] ?? false,
                    label: keys[index],
                    onPressed: () {
                      onSelectButton(keys[index]);
                      print('future change date event');
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 12),
              ),
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

  void onSelectButton(String value) {
    setState(() {
      bool lastAnswer = widget.dates[value] ?? false;
      widget.dates[value] = !lastAnswer;
    });
  }
}
