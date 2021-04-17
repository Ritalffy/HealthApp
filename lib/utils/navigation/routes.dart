import 'package:flutter/material.dart';
import 'package:health_app/home/home.dart';
import 'package:health_app/loader/loader.dart';
import 'package:health_app/login/login.dart';
import 'package:health_app/registration/view/registration_page.dart';

abstract class Routes {
  Routes._();

  static const String start = '/';
  static const String home = '/home';

  static const String register = '/register';
  static const String loading = '/loading';

  static Route<void> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute<void>(
          builder: (_) => LoginPage(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute<void>(
          builder: (_) => HomePage(),
          settings: settings,
        );
      case loading:
        return MaterialPageRoute<void>(
          builder: (_) => LoaderPage(),
          settings: settings,
        );
      case register:
        return MaterialPageRoute<void>(
          builder: (_) => RegisterPage(),
          settings: settings,
        );

      default:
        throw Exception('No route defined for "${settings.name}"');
    }
  }
}
