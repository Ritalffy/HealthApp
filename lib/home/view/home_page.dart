import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/utils/navigation/routes.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.logout) {
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(Routes.start, (route) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
        body: Builder(
          builder: (context) {
            return Column(
              children: [
                TableCalendar(
                  availableGestures: AvailableGestures.horizontalSwipe,
                  firstDay: DateTime.now().subtract(Duration(days: 120)),
                  lastDay: DateTime.now(),
                  focusedDay: DateTime.now(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
