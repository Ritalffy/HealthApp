import 'package:flutter/material.dart';
import 'package:health_app/utils/navigation/routes.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return Scaffold(
          key: _scaffoldKey,
          body: child,
          resizeToAvoidBottomInset: false,
        );
      },
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.start,
    );
  }
}
