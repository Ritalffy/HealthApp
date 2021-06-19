import 'package:flutter/material.dart';
import 'package:health_app/utils/navigation/dashboard_routes.dart';
import 'package:health_app/widgets/cards/primary_card.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          PrimaryCard(
            description: 'Check scheduled visitis',
            iconData: Icons.check,
            buttonLabel: 'Check',
            onPressed: () => Navigator.of(context, rootNavigator: false)
                .pushNamed<void>(DashboardRoutes.appointments),
          ),
          const SizedBox(height: 12),
          PrimaryCard(
            description: 'Update your account information',
            iconData: Icons.supervised_user_circle,
            buttonLabel: 'Edit data',
            onPressed: () => {},
          ),
        ],
      ),
    );
  }
}
