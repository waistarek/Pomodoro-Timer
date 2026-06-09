import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'auth_error_text.dart';
import 'login_register_form.dart';

class PasswordResetRequestForm extends StatelessWidget {
  const PasswordResetRequestForm({
    super.key,
    required this.emailController,
    required this.loading,
    required this.error,
    required this.onSubmit,
    required this.onBackToLogin,
    required this.validateEmail,
  });

  final TextEditingController emailController;
  final bool loading;
  final String? error;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;
  final AuthFieldValidator validateEmail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.passwordResetTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.passwordResetDescription,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        ),
        const SizedBox(height: 16),
        AuthErrorText(error: error),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: loading ? null : onSubmit,
            icon: const Icon(Icons.mail_outline),
            label: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.sendResetLink),
          ),
        ),
        TextButton(
          onPressed: loading ? null : onBackToLogin,
          child: Text(l10n.backToLogin),
        ),
      ],
    );
  }
}
