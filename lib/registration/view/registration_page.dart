import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/registration/view/registration_form.dart';

class RegisterPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => RegisterPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: BlocProvider(
          create: (context) => RegistrationBloc(),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: RegistrationForm(),
          )),
    );
  }
}
