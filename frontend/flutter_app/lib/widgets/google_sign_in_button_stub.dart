import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class GoogleWebSignInButton extends StatelessWidget {
  const GoogleWebSignInButton({
    super.key,
    required this.enabled,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Semantics(
      button: true,
      enabled: false,
      label: l10n.googleSignInSemantics,
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: null,
          icon: const ExcludeSemantics(child: Icon(Icons.login)),
          label: Text(l10n.googleWebOnly),
        ),
      ),
    );
  }
}
