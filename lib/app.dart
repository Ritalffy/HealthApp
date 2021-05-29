import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_api/health_api.dart';
import 'package:health_app/app_view.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatefulWidget {
  final String apiUrl;
  const App({required this.apiUrl});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late HealthApi _api;
  late AuthenticationRepository _authenticationRepository;
  late UserRepository _userRepository;

  @override
  void initState() {
    _api = HealthApi(url: widget.apiUrl);
    _authenticationRepository = AuthenticationRepository(api: _api);
    _userRepository = UserRepository();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}
