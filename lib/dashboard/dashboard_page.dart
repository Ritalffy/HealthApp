import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/blocs/authentication/bloc/authentication_bloc.dart';
import 'package:health_app/utils/navigation/dashboard_routes.dart';
import 'package:health_app/utils/navigation/dashboard_tab.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DashboardRoutes dashboardRoutes;
  int _selectedIndex = 0;
  final _navigatorKeys = {
    DashboardTab.home: GlobalKey<NavigatorState>(),
    DashboardTab.appointments: GlobalKey<NavigatorState>(),
    DashboardTab.setting: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    dashboardRoutes = DashboardRoutes(authenticationBloc: authenticationBloc);
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          Navigator(
            key: _navigatorKeys[DashboardTab.home],
            initialRoute: DashboardRoutes.home,
            onGenerateRoute: generateRoute,
            onGenerateInitialRoutes: onGenerateInitialRoutes,
          ),
          Navigator(
            key: _navigatorKeys[DashboardTab.appointments],
            initialRoute: DashboardRoutes.appointments,
            onGenerateRoute: generateRoute,
            onGenerateInitialRoutes: onGenerateInitialRoutes,
          ),
          Navigator(
            key: _navigatorKeys[DashboardTab.setting],
            initialRoute: DashboardRoutes.setting,
            onGenerateRoute: generateRoute,
            onGenerateInitialRoutes: onGenerateInitialRoutes,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Route<void> generateRoute(RouteSettings settings) {
    return dashboardRoutes.generateRoute(settings);
  }

  List<Route<void>> onGenerateInitialRoutes(
    NavigatorState navigator,
    String initialRoute,
  ) =>
      [generateRoute(RouteSettings(name: initialRoute))];
}
