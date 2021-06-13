import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? color;
  final bool isSelected;

  const PrimaryButton({
    required this.label,
    this.onPressed,
    this.color,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(label),
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
        foregroundColor: MaterialStateProperty.all<Color>(
            isSelected ? Colors.greenAccent : color ?? Colors.blueAccent),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
                color: isSelected
                    ? Colors.greenAccent
                    : color ?? color ?? Colors.blueAccent),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
