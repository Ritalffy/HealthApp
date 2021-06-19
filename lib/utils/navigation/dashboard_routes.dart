import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/home/view/home_page.dart';
import 'package:health_app/my_appointments/scheduled_appointments.dart';
import 'package:health_app/patient_appointments/patient_appointments_page.dart';

import 'package:health_app/settings/settings_page.dart';

class DashboardRoutes {
  static const _baseRoute = '/';
  static const home = '$_baseRoute/home';
  static const appointments = '$_baseRoute/appointments';
  static const setting = '$_baseRoute/settings';
  static const edit = '$_baseRoute/edit';
  static const patientAppointments =
      '$_baseRoute/patient/appointments/schedule';

  late AuthenticationBloc authenticationBloc;

  DashboardRoutes({
    required this.authenticationBloc,
  });

  Route<void> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case DashboardRoutes.home:
        return MaterialPageRoute<void>(
            builder: (_) => HomePage(), settings: settings);
      case appointments:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider.value(
              value: authenticationBloc, child: ScheduledAppointments()),
          settings: settings,
        );
      case patientAppointments:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider.value(
              value: authenticationBloc, child: PatientAppointmentsPage()),
          settings: settings,
        );

      case setting:
        return MaterialPageRoute<void>(
          builder: (_) => BlocProvider.value(
              value: authenticationBloc, child: SettingsPage()),
          settings: settings,
        );

      default:
        throw Exception('No route defined for "${settings.name}"');
    }
  }
}
