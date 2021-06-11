import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_api/health_api.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/registration/bloc/registration_bloc.dart';
import 'package:health_app/utils/navigation/routes.dart';
import 'package:register_repository/register_repository.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatefulWidget {
  final String apiUrl;
  const App({required this.apiUrl});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  late RegistrationBloc _registrationBloc;
  late AuthenticationBloc _authenticationBloc;

  late HealthApi _api;
  late AuthenticationRepository _authenticationRepository;
  late RegisterRepository _registerRepository;
  late UserRepository _userRepository;

  late Routes routes;

  @override
  void initState() {
    _api = HealthApi(url: widget.apiUrl);
    _authenticationRepository = AuthenticationRepository(api: _api);
    _userRepository = UserRepository();
    _registerRepository = RegisterRepository(api: _api);

    _registrationBloc =
        RegistrationBloc(registerRepository: _registerRepository);
    _authenticationBloc = AuthenticationBloc(
        authenticationRepository: _authenticationRepository,
        userRepository: _userRepository);

    routes = Routes(
      registrationBloc: _registrationBloc,
      authenticationBloc: _authenticationBloc,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: _authenticationRepository,
          child: BlocProvider(
            create: (_) => _authenticationBloc,
          ),
        ),
        RepositoryProvider.value(
          value: _registerRepository,
          child: BlocProvider(
            create: (_) => _registrationBloc,
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(backgroundColor: Color.fromRGBO(240, 240, 240, 0.4)),
        builder: (context, child) {
          return Scaffold(
            body: child,
            resizeToAvoidBottomInset: false,
          );
        },
        onGenerateRoute: routes.generateRoute,
      ),
    );
  }
}
