import 'package:flutter/material.dart';

class InitialView extends StatelessWidget {
  const InitialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome to scheduling process',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
