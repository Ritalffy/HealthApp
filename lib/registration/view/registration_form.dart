import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/registration/view/widgets/professions_register_wrapper.dart';

import 'package:health_app/registration/view/widgets/role_dropdown.dart';
import 'package:health_app/utils/navigation/routes.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';

class RegistrationForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationBlocState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Registration Failure')),
            );
        }
        if (state.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Registration Sucessful')),
            );
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil<void>(
                  RoutesName.start, (route) => false);
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: ListView(
          children: [
            const SizedBox(height: 40),
            _EmailInput(),
            const SizedBox(height: 12),
            _PasswordInput(),
            const SizedBox(height: 12),
            RoleDropdown(),
            const SizedBox(height: 12),
            ProfessionsRegisterWrapper(),
            const SizedBox(height: 130),
            const Divider(thickness: 2),
            const SizedBox(height: 12),
            _RegisterButton(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          onChanged: (email) =>
              context.read<RegistrationBloc>().add(RegisterEmailChanged(email)),
          decoration: InputDecoration(
            labelText: 'email',
            errorText: state.email.invalid ? 'invalid email' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          onChanged: (password) => context
              .read<RegistrationBloc>()
              .add(RegisterPasswordChanged(password)),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'password',
            errorText: state.password.invalid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator.adaptive()
            : Row(
                children: [
                  Expanded(
                    child: PrimaryButton(
                      label: 'Register',
                      onPressed: state.status.isValidated
                          ? () {
                              context
                                  .read<RegistrationBloc>()
                                  .add(const RegisterSubmitted());
                            }
                          : null,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
