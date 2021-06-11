import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/utils/navigation/routes.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

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
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.supervised_user_circle),
              title: Text('Edit profile'),
              trailing: const Icon(Icons.arrow_forward_ios),
              // TODO: (Wiktoria) add edition profile page
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: Text('Log out'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              },
            ),
            const Divider()
          ],
        ),
      ),
    );
  }
}
