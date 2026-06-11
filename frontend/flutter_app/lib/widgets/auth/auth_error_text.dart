import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'auth_helpers.dart';

class AuthErrorText extends StatelessWidget {
  const AuthErrorText({
    super.key,
    required this.error,
  });

  final String? error;

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox.shrink();
    }

    final message = localizedAuthError(context, error!);
    final l10n = AppLocalizations.of(context);

    return Semantics(
      container: true,
      liveRegion: true,
      label: l10n.authErrorSemantics(message),
      child: Text(
        message,
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
