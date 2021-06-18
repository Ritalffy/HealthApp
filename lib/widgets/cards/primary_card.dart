import 'package:flutter/material.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';
import 'package:health_app/widgets/cards/card_base.dart';

class PrimaryCard extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback onPressed;
  final IconData iconData;
  const PrimaryCard({
    required this.description,
    required this.iconData,
    required this.onPressed,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(iconData),
              const SizedBox(width: 10),
              Text(description),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Spacer(),
              PrimaryButton(
                label: buttonLabel,
                onPressed: onPressed,
              )
            ],
          )
        ],
      ),
    );
  }
}
