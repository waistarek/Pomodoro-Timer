import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'auth_error_text.dart';
import 'login_register_form.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.loading,
    required this.error,
    required this.onSubmit,
    required this.onBackToLogin,
    required this.validatePassword,
  });

  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool loading;
  final String? error;
  final VoidCallback onSubmit;
  final VoidCallback onBackToLogin;
  final AuthFieldValidator validatePassword;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          l10n.setNewPasswordTitle,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          l10n.setNewPasswordDescription,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: l10n.newPasswordLabel,
          ),
          obscureText: true,
          validator: validatePassword,
        ),
        TextFormField(
          controller: confirmPasswordController,
          decoration: InputDecoration(
            labelText: l10n.repeatNewPasswordLabel,
          ),
          obscureText: true,
          validator: (value) {
            if (value != passwordController.text) {
              return l10n.passwordsDoNotMatch;
            }

            return null;
          },
        ),
        const SizedBox(height: 16),
        AuthErrorText(error: error),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: loading ? null : onSubmit,
            icon: const Icon(Icons.lock_reset),
            label: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(l10n.savePassword),
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
