import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/registration/models/role_model_keys.dart';

class RoleDropdown extends StatefulWidget {
  const RoleDropdown({Key? key}) : super(key: key);

  @override
  _RoleDropdownState createState() => _RoleDropdownState();
}

class _RoleDropdownState extends State<RoleDropdown> {
  String dropdownValue = RoleModelKeys.patient;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          width: double.infinity,
          child: DropdownButton<String>(
            value: dropdownValue,
            onChanged: _onRoleChanged,
            items: <String>[RoleModelKeys.patient, RoleModelKeys.doctor]
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
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
      if (role == 'doctor') {
        context.read<RegistrationBloc>().add(DoctorRoleSelected());
      }
    }
  }
}
