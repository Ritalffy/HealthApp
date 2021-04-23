import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';

import 'package:health_app/registration/view/widgets/role_dropdown.dart';
import 'package:health_app/utils/navigation/routes.dart';

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
              .pushNamedAndRemoveUntil<void>(Routes.home, (route) => false);
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _EmailInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _PasswordInput(),
            const Padding(padding: EdgeInsets.all(12)),
            _ProfessionInput(),
            const Padding(padding: EdgeInsets.all(12)),
            RoleDropdown(),
            const Padding(padding: EdgeInsets.all(12)),
            _RegisterButton(),
            const Padding(padding: EdgeInsets.all(12)),
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
          key: const Key('RegistrationForm_emailInput_textField'),
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
          key: const Key('RegistrationForm_passwordInput_textField'),
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

class _ProfessionInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationBlocState>(
      buildWhen: (previous, current) =>
          previous.profession != current.profession,
      builder: (context, state) {
        return TextField(
          key: const Key('RegistrationForm_professionInput_textField'),
          onChanged: (prosession) => context
              .read<RegistrationBloc>()
              .add(RegisterProfessionChanged(prosession)),
          decoration: InputDecoration(
            labelText: 'profession',
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
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('RegistrationForm_continue_raisedButton'),
                child: const Text('Register'),
                onPressed: state.status.isValidated
                    ? () {
                        context
                            .read<RegistrationBloc>()
                            .add(const RegisterSubmitted());
                      }
                    : null,
              );
      },
    );
  }
}
