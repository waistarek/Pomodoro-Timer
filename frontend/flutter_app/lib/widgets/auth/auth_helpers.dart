import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/session_sync_provider.dart';

String maskEmail(String email) {
  final parts = email.split('@');

  if (parts.length != 2) {
    return email;
  }

  final name = parts[0];
  final domain = parts[1];

  if (name.isEmpty) {
    return '***@$domain';
  }

  if (name.length <= 2) {
    return '${name.substring(0, 1)}***@$domain';
  }

  final visibleStart = name.substring(0, 2);
  return '$visibleStart***@$domain';
}

String formatAccountDate(DateTime date, AppLocalizations l10n) {
  return DateFormat.yMd(l10n.localeName).format(date.toLocal());
}

String syncStatusText(
  SessionSyncProvider provider,
  AppLocalizations l10n,
) {
  if (provider.syncing) {
    return l10n.syncRunning;
  }

  if (provider.pendingCount == 1) {
    return l10n.syncOneWaiting;
  }

  if (provider.pendingCount > 1) {
    return l10n.syncManyWaiting(provider.pendingCount);
  }

  if (provider.error != null) {
    return l10n.syncError;
  }

  return l10n.syncAllSynced;
}

String localizedAuthError(BuildContext context, String error) {
  final l10n = AppLocalizations.of(context);

  if (error == 'Deine Sitzung ist abgelaufen. Bitte logge dich erneut ein.') {
    return l10n.sessionExpired;
  }

  if (error == 'Google hat keinen gültigen ID-Token zurückgegeben.') {
    return l10n.googleNoIdToken;
  }

  if (error == 'GitHub hat keinen gültigen Code zurückgegeben.') {
    return l10n.githubNoValidCode;
  }

  return error;
}
