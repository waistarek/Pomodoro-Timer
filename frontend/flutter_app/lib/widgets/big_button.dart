import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
  const BigButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.filled = true,
    this.semanticLabel,
    this.tooltip,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool filled;
  final String? semanticLabel;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final effectiveSemanticLabel = semanticLabel ?? label;

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ExcludeSemantics(child: Icon(icon)),
        const SizedBox(width: 8),
        Text(label),
      ],
    );

    final button = filled
        ? FilledButton(onPressed: onPressed, child: child)
        : OutlinedButton(onPressed: onPressed, child: child);

    return Semantics(
      button: true,
      enabled: onPressed != null,
      label: effectiveSemanticLabel,
      child: Tooltip(
        message: tooltip ?? effectiveSemanticLabel,
        child: SizedBox(
          height: 52,
          child: ExcludeSemantics(child: button),
        ),
      ),
    );
  }
}