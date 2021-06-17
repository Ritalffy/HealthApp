import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/registration/models/role_model_keys.dart';

class ProfessionsDropdown extends StatefulWidget {
  const ProfessionsDropdown({Key? key}) : super(key: key);

  @override
  _ProfessionsDropdownState createState() => _ProfessionsDropdownState();
}

class _ProfessionsDropdownState extends State<ProfessionsDropdown> {
  String dropdownValue = RoleModelKeys.patient;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        if (state.professionStatus == ProfessionStatus.fetched)
          return Container(
            width: double.infinity,
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: _onProfessionChanged,
              items: [
                for (final profession in state.avaiableProfessions)
                  DropdownMenuItem(child: Text(profession), value: profession),
              ],
            ),
          );
        else if (state.professionStatus == ProfessionStatus.loading)
          return CircularProgressIndicator();

        return Container();
      },
    );
  }

  void _onProfessionChanged(String? profession) {
    setState(() {
      dropdownValue = profession!;
    });
    if (profession != null) {
      context
          .read<RegistrationBloc>()
          .add(RegisterProfessionChanged(profession));
    }
  }
}
