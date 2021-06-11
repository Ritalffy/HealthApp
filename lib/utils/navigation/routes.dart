import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/dashboard/dashboard_page.dart';
import 'package:health_app/loader/loader.dart';
import 'package:health_app/login/login.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/registration/view/registration_page.dart';

class RoutesName {
  static const String start = '/';
  static const String dashboard = '/dashboard';

  static const String register = '/register';
  static const String loading = '/loading';
}

class Routes {
  late RegistrationBloc registrationBloc;
  late AuthenticationBloc authenticationBloc;

  Routes({
    required this.registrationBloc,
    required this.authenticationBloc,
  });
  Route<void> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.start:
        return MaterialPageRoute<void>(
          builder: (_) =>
              BlocProvider.value(value: authenticationBloc, child: LoginPage()),
          settings: settings,
        );
      case RoutesName.dashboard:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider.value(
              value: authenticationBloc, child: DashboardPage()),
          settings: settings,
        );
      case RoutesName.loading:
        return MaterialPageRoute<void>(
          builder: (_) => LoaderPage(),
          settings: settings,
        );
      case RoutesName.register:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider.value(
              value: registrationBloc, child: RegisterPage()),
          settings: settings,
        );

      default:
        throw Exception('No route defined for "${settings.name}"');
    }
  }
}
