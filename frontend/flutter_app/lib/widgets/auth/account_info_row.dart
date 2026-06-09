import 'package:flutter/material.dart';

class AccountInfoRow extends StatelessWidget {
  const AccountInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.tooltip,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final valueWidget = Text(
      value,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              tooltip == null
                  ? valueWidget
                  : Tooltip(
                      message: tooltip!,
                      child: valueWidget,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}
