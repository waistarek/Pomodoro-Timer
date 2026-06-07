import 'package:flutter/material.dart';
import 'package:google_sign_in_web/web_only.dart' as google_web;

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

    return IgnorePointer(
      ignoring: !enabled,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.55,
        child: Center(
          child: google_web.renderButton(
            configuration: google_web.GSIButtonConfiguration(
              type: google_web.GSIButtonType.standard,
              theme: google_web.GSIButtonTheme.outline,
              size: google_web.GSIButtonSize.large,
              text: google_web.GSIButtonText.signinWith,
              minimumWidth: 360,
              locale: l10n.localeName,
            ),
          ),
        ),
      ),
    );
  }
}
