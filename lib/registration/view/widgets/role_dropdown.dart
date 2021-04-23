import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({Key? key}) : super(key: key);

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String dropdownValue = 'patient';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return DropdownButton<String>(
          value: dropdownValue,
          onChanged: _onRoleChanged,
          items: <String>['patient', 'doctor']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        );
      },
    );
  }

  void _onRoleChanged(String? role) {
    setState(() {
      dropdownValue = role!;
    });
    if (role != null) {
      context.read<RegistrationBloc>().add(RegisterRoleChanged(role));
    }
  }
}
