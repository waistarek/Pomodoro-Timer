import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import 'auth_error_text.dart';

typedef AuthFieldValidator = String? Function(String? value);

class LoginRegisterForm extends StatelessWidget {
  const LoginRegisterForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.registerMode,
    required this.rememberSession,
    required this.loading,
    required this.error,
    required this.onSubmit,
    required this.onForgotPassword,
    required this.onToggleRegisterMode,
    required this.onRememberSessionChanged,
    required this.validateEmail,
    required this.validatePassword,
    required this.oauthSection,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool registerMode;
  final bool rememberSession;
  final bool loading;
  final String? error;
  final VoidCallback onSubmit;
  final VoidCallback onForgotPassword;
  final VoidCallback onToggleRegisterMode;
  final ValueChanged<bool> onRememberSessionChanged;
  final AuthFieldValidator validateEmail;
  final AuthFieldValidator validatePassword;
  final Widget oauthSection;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = registerMode ? l10n.createAccountTitle : l10n.loginTitle;
    final emailPasswordTitle = registerMode
        ? l10n.emailPasswordCreateTitle
        : l10n.emailPasswordLoginTitle;
    final submitLabel =
        registerMode ? l10n.createAccountButton : l10n.loginButton;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        Text(
          emailPasswordTitle,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        TextFormField(
          controller: emailController,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
        ),
        TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            labelText: l10n.passwordLabel,
          ),
          obscureText: true,
          validator: validatePassword,
        ),
        if (!registerMode)
          CheckboxListTile(
            value: rememberSession,
            onChanged: loading
                ? null
                : (value) {
                    onRememberSessionChanged(value ?? true);
                  },
            title: Text(l10n.rememberSessionTitle),
            subtitle: Text(l10n.rememberSessionSubtitle),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        const SizedBox(height: 16),
        AuthErrorText(error: error),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: loading ? null : onSubmit,
            child: loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(submitLabel),
          ),
        ),
        if (!registerMode) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: loading ? null : onForgotPassword,
            child: Text(l10n.forgotPasswordButton),
          ),
        ],
        TextButton(
          onPressed: loading ? null : onToggleRegisterMode,
          child: Text(
            registerMode ? l10n.alreadyHaveAccount : l10n.createAccountTitle,
          ),
        ),
        const SizedBox(height: 8),
        oauthSection,
      ],
    );
  }
}
