import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/auth_provider.dart';
import '../../providers/session_sync_provider.dart';
import 'account_info_row.dart';
import 'auth_error_text.dart';
import 'auth_helpers.dart';

class LoggedInAccountCard extends StatelessWidget {
  const LoggedInAccountCard({
    super.key,
    required this.provider,
    required this.sessionSyncProvider,
    required this.onChangePassword,
    required this.onLogout,
  });

  final AuthProvider provider;
  final SessionSyncProvider sessionSyncProvider;
  final VoidCallback onChangePassword;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final user = provider.user!;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_user, size: 64),
            const SizedBox(height: 16),
            Text(
              l10n.loggedInTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.loggedInDescription,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AccountInfoRow(
              icon: Icons.email_outlined,
              label: l10n.emailAddress,
              value: maskEmail(user.email),
              tooltip: user.email,
            ),
            const SizedBox(height: 12),
            AccountInfoRow(
              icon: user.isEmailVerified
                  ? Icons.mark_email_read_outlined
                  : Icons.mark_email_unread_outlined,
              label: l10n.emailStatus,
              value: user.isEmailVerified
                  ? l10n.emailVerified
                  : l10n.emailNotVerified,
            ),
            const SizedBox(height: 12),
            AccountInfoRow(
              icon: Icons.calendar_today_outlined,
              label: l10n.accountCreated,
              value: formatAccountDate(user.createdAt, l10n),
            ),
            const SizedBox(height: 12),
            AccountInfoRow(
              icon: Icons.sync_outlined,
              label: l10n.synchronization,
              value: syncStatusText(sessionSyncProvider, l10n),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      l10n.accountInfoWarning,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            AuthErrorText(error: provider.error),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: provider.loading ? null : onChangePassword,
                icon: const Icon(Icons.lock_reset),
                label: Text(l10n.changePassword),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: provider.loading ? null : onLogout,
                icon: const Icon(Icons.logout),
                label: Text(l10n.logout),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
