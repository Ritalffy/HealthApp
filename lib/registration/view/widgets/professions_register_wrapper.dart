import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/registration/view/widgets/professions_dropdown.dart';

class ProfessionsRegisterWrapper extends StatelessWidget {
  const ProfessionsRegisterWrapper({Key? key}) : super(key: key);

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
              return Container(
                  width: double.infinity,
                  child: RegistrationProfessionDropdown(
                    professions: state.avaiableProfessions,
                  ));

            default:
              return Container();
          }
        else {
          return Container();
        }
      },
    );
  }
}
