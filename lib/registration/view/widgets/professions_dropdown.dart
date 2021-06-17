import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';

class ProfessionsDropdown extends StatefulWidget {
  const ProfessionsDropdown({Key? key}) : super(key: key);

  @override
  _ProfessionsDropdownState createState() => _ProfessionsDropdownState();
}

class _ProfessionsDropdownState extends State<ProfessionsDropdown> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) =>
          previous.role != current.role ||
          previous.avaiableProfessions.length !=
              current.avaiableProfessions.length,
      builder: (context, state) {
        if (state.role == 'doctor')
          switch (state.professionStatus) {
            case ProfessionStatus.loading:
              return const CircularProgressIndicator.adaptive();

            case ProfessionStatus.error:
              return Text('error occurred');

            case ProfessionStatus.fetched:
              dropdownValue = state.avaiableProfessions[0];
              return Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  value: dropdownValue,
                  onChanged: _onProfessionChanged,
                  items: [
                    for (final profession in state.avaiableProfessions)
                      DropdownMenuItem(
                          child: Text(profession), value: profession),
                  ],
                ),
              );

            default:
              return Container();
          }
        else {
          return Container();
        }
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
