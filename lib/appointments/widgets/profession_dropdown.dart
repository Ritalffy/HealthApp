import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/appointments/bloc/appointment_bloc.dart';

class ProfessionDropdown extends StatefulWidget {
  final List<String> professions;
  const ProfessionDropdown({
    required this.professions,
  });

  @override
  _ProfessionDropdownState createState() => _ProfessionDropdownState();
}

class _ProfessionDropdownState extends State<ProfessionDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.professions.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppointmentBloc, AppointmentState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          child: DropdownButton<String>(
            value: dropdownValue,
            onChanged: _onProfessionChanged,
            items: _buildDropDownMenuItems(),
            icon: null,
          ),
        );
      },
    );
  }

  void _onProfessionChanged(String? profession) {
    setState(() {
      dropdownValue = profession!;
    });
    if (profession != null) {
      context.read<AppointmentBloc>().add(ProfessionChanged(profession));
    }
  }

  List<DropdownMenuItem<String>> _buildDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (final profession in widget.professions) {
      items.add(
        DropdownMenuItem(
          child: Text(profession),
          value: profession,
        ),
      );
    }
    return items;
  }
}
