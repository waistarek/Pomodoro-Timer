import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton(
      {super.key,
      required this.label,
      required this.icon,
      required this.onPressed,
      this.filled = true});

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 8),
        Text(label),
      ],
    );
    return SizedBox(
      height: 52,
      child: filled
          ? FilledButton(onPressed: onPressed, child: child)
          : OutlinedButton(onPressed: onPressed, child: child),
    );
  }
}
