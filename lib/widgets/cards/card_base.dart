import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardBase extends StatelessWidget {
  final Color color;
  final Widget? child;
  final bool enabledShadow;

  const CardBase({
    required this.child,
    this.color = Colors.white,
    this.enabledShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color,
        border:
            Border.all(width: 2.0, color: Colors.blueAccent.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: enabledShadow
            ? [
                const BoxShadow(
                  color: Color(0x0a31306f),
                  offset: Offset(0, 4),
                  blurRadius: 30,
                )
              ]
            : null,
      ),
      child: child ?? Container(),
    );
  }
}
