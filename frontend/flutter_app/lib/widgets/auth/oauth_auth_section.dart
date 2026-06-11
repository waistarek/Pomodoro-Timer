import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../google_sign_in_button.dart';

class OauthAuthSection extends StatelessWidget {
  const OauthAuthSection({
    super.key,
    required this.registerMode,
    required this.loading,
    required this.googleConfigured,
    required this.googleReady,
    required this.githubConfigured,
    required this.onStartGithubOAuth,
  });

  final bool registerMode;
  final bool loading;
  final bool googleConfigured;
  final bool googleReady;
  final bool githubConfigured;
  final VoidCallback onStartGithubOAuth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(l10n.or),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 16),
        _GoogleAuthSection(
          registerMode: registerMode,
          loading: loading,
          googleConfigured: googleConfigured,
          googleReady: googleReady,
        ),
        const SizedBox(height: 16),
        _GithubAuthSection(
          registerMode: registerMode,
          loading: loading,
          githubConfigured: githubConfigured,
          onStartGithubOAuth: onStartGithubOAuth,
        ),
      ],
    );
  }
}

class _GoogleAuthSection extends StatelessWidget {
  const _GoogleAuthSection({
    required this.registerMode,
    required this.loading,
    required this.googleConfigured,
    required this.googleReady,
  });

  final bool registerMode;
  final bool loading;
  final bool googleConfigured;
  final bool googleReady;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final description =
        registerMode ? l10n.googleCreateButton : l10n.googleLoginButton;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.googleSection,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (!googleConfigured)
          Text(l10n.googleNotConfigured)
        else if (!googleReady)
          Text(l10n.googlePreparing)
        else
          GoogleWebSignInButton(
            enabled: !loading,
          ),
      ],
    );
  }
}

class _GithubAuthSection extends StatelessWidget {
  const _GithubAuthSection({
    required this.registerMode,
    required this.loading,
    required this.githubConfigured,
    required this.onStartGithubOAuth,
  });

  final bool registerMode;
  final bool loading;
  final bool githubConfigured;
  final VoidCallback onStartGithubOAuth;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final description =
        registerMode ? l10n.githubCreateButton : l10n.githubLoginButton;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.githubSection,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        if (!githubConfigured)
          Text(l10n.githubNotConfigured)
        else
          Tooltip(
            message: l10n.githubSignInSemantics,
            child: OutlinedButton.icon(
              onPressed: loading ? null : onStartGithubOAuth,
              icon: const ExcludeSemantics(child: Icon(Icons.code)),
              label: Text(description),
            ),
          ),
      ],
    );
  }
}
