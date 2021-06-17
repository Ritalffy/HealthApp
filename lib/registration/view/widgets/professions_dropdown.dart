import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';

class RegistrationProfessionDropdown extends StatefulWidget {
  final List<String> professions;
  const RegistrationProfessionDropdown({
    required this.professions,
  });

  @override
  _RegistrationProfessionDropdownState createState() =>
      _RegistrationProfessionDropdownState();
}

class _RegistrationProfessionDropdownState
    extends State<RegistrationProfessionDropdown> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.professions.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
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
    context
        .read<RegistrationBloc>()
        .add(RegisterProfessionChanged(dropdownValue));
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
