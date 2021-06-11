import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/utils/navigation/routes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.status == AuthenticationStatus.logout) {
          Navigator.of(context, rootNavigator: true)
              .pushNamedAndRemoveUntil(RoutesName.start, (route) => false);
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
            return Center(
              child: Text('home'),
            );
          },
        ),
      ),
    );
  }
}
