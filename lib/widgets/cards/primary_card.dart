import 'package:flutter/material.dart';
import 'package:health_app/widgets/buttons/primary_button.dart';
import 'package:health_app/widgets/cards/card_base.dart';

class PrimaryCard extends StatelessWidget {
  final String description;
  final String buttonLabel;
  final VoidCallback? onPressed;
  final IconData iconData;
  final bool isSelected;
  const PrimaryCard({
    required this.description,
    required this.iconData,
    this.onPressed,
    this.isSelected = false,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return CardBase(
      color: isSelected ? Colors.greenAccent : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            children: [
              Icon(iconData),
              const SizedBox(width: 10),
              Text(description),
            ],
          ),
          const SizedBox(height: 10),
          if (onPressed != null)
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
