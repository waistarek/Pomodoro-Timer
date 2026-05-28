import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/session_sync_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/stats_provider.dart';
import '../providers/task_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _registerMode = false;
  bool _forgotPasswordMode = false;
  String? _resetToken;

  bool get _resetPasswordMode => _resetToken != null;

  @override
  void initState() {
    super.initState();

    final uri = Uri.base;
    _resetToken = uri.queryParameters['reset_token'];

    final email = uri.queryParameters['email'];
    if (email != null && email.isNotEmpty) {
      _emailController.text = email;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benutzerkonto')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Consumer<AuthProvider>(
            builder: (context, provider, _) {
              if (provider.user != null && !_resetPasswordMode) {
                return _LoggedInCard(provider: provider);
              }

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: _buildAuthForm(context, provider),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAuthForm(BuildContext context, AuthProvider provider) {
    if (_resetPasswordMode) {
      return _buildResetPasswordForm(context, provider);
    }

    if (_forgotPasswordMode) {
      return _buildForgotPasswordForm(context, provider);
    }

    return _buildLoginRegisterForm(context, provider);
  }

  Widget _buildLoginRegisterForm(
    BuildContext context,
    AuthProvider provider,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _registerMode ? 'Registrieren' : 'Login',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'E-Mail',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Passwort',
          ),
          obscureText: true,
          validator: _validatePassword,
        ),
        const SizedBox(height: 16),
        _AuthErrorText(error: provider.error),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: provider.loading ? null : () => _submit(context),
            child: provider.loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(
                    _registerMode ? 'Konto erstellen' : 'Einloggen',
                  ),
          ),
        ),
        const SizedBox(height: 8),
        if (!_registerMode)
          TextButton(
            onPressed: provider.loading
                ? null
                : () {
                    provider.clearError();
                    setState(() {
                      _forgotPasswordMode = true;
                    });
                  },
            child: const Text('Passwort vergessen?'),
          ),
        TextButton(
          onPressed: provider.loading
              ? null
              : () {
                  provider.clearError();
                  setState(() => _registerMode = !_registerMode);
                },
          child: Text(
            _registerMode
                ? 'Ich habe bereits ein Konto'
                : 'Neues Konto erstellen',
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordForm(
    BuildContext context,
    AuthProvider provider,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Passwort zurücksetzen',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Gib deine E-Mail-Adresse ein. Wenn ein Konto existiert, bekommst du einen Link zum Zurücksetzen.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'E-Mail',
          ),
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        const SizedBox(height: 16),
        _AuthErrorText(error: provider.error),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: provider.loading
                ? null
                : () => _submitPasswordResetRequest(context),
            icon: const Icon(Icons.mail_outline),
            label: provider.loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Reset-Link senden'),
          ),
        ),
        TextButton(
          onPressed: provider.loading
              ? null
              : () {
                  provider.clearError();
                  setState(() {
                    _forgotPasswordMode = false;
                  });
                },
          child: const Text('Zurück zum Login'),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm(
    BuildContext context,
    AuthProvider provider,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Neues Passwort setzen',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        Text(
          'Lege ein neues Passwort für dein Konto fest.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _passwordController,
          decoration: const InputDecoration(
            labelText: 'Neues Passwort',
          ),
          obscureText: true,
          validator: _validatePassword,
        ),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: const InputDecoration(
            labelText: 'Neues Passwort wiederholen',
          ),
          obscureText: true,
          validator: (value) {
            if (value != _passwordController.text) {
              return 'Die Passwörter stimmen nicht überein';
            }

            return null;
          },
        ),
        const SizedBox(height: 16),
        _AuthErrorText(error: provider.error),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: provider.loading
                ? null
                : () => _submitResetPassword(context),
            icon: const Icon(Icons.lock_reset),
            label: provider.loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Passwort speichern'),
          ),
        ),
        TextButton(
          onPressed: provider.loading
              ? null
              : () {
                  provider.clearError();
                  setState(() {
                    _resetToken = null;
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  });
                },
          child: const Text('Zurück zum Login'),
        ),
      ],
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final taskProvider = context.read<TaskProvider>();
    final settingsProvider = context.read<SettingsProvider>();
    final sessionSyncProvider = context.read<SessionSyncProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final wasRegisterMode = _registerMode;
    final ok = _registerMode
        ? await authProvider.register(email, password)
        : await authProvider.login(email, password);

    if (!mounted) {
      return;
    }

    if (ok) {
      if (wasRegisterMode) {
        setState(() => _registerMode = false);

        messenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Registrierung erfolgreich. Bitte bestätige deine E-Mail-Adresse und logge dich danach ein.',
            ),
          ),
        );

        return;
      }

      await settingsProvider.loadRemoteSettings();
      await taskProvider.loadRemoteTasks();

      unawaited(
        _syncStoredSessionsAfterLogin(
          sessionSyncProvider,
          taskProvider,
        ),
      );

      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        const SnackBar(content: Text('Erfolgreich angemeldet.')),
      );
    }
  }

  Future<void> _submitPasswordResetRequest(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final ok = await authProvider.requestPasswordReset(
      _emailController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (ok) {
      setState(() {
        _forgotPasswordMode = false;
      });

      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Wenn ein Konto mit dieser E-Mail existiert, wurde ein Reset-Link gesendet.',
          ),
        ),
      );
    }
  }

  Future<void> _submitResetPassword(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final token = _resetToken;

    if (token == null) {
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final ok = await authProvider.resetPassword(
      token,
      _passwordController.text,
    );

    if (!mounted) {
      return;
    }

    if (ok) {
      setState(() {
        _resetToken = null;
        _forgotPasswordMode = false;
        _passwordController.clear();
        _confirmPasswordController.clear();
      });

      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Passwort wurde geändert. Du kannst dich jetzt einloggen.',
          ),
        ),
      );
    }
  }

  Future<void> _syncStoredSessionsAfterLogin(
    SessionSyncProvider sessionSyncProvider,
    TaskProvider taskProvider,
  ) async {
    await sessionSyncProvider.syncStoredSessions();

    if (!mounted) {
      return;
    }

    await taskProvider.refreshTaskPomodoroCounts();
  }

  String? _validateEmail(String? value) {
    final email = value?.trim() ?? '';

    if (!email.contains('@')) {
      return 'Bitte gültige E-Mail eingeben';
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return 'Mindestens 8 Zeichen';
    }

    return null;
  }
}

class _LoggedInCard extends StatelessWidget {
  const _LoggedInCard({required this.provider});

  final AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_user, size: 64),
            const SizedBox(height: 16),
            Text(
              'Angemeldet als',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(provider.user!.email),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () async {
                final authProvider = context.read<AuthProvider>();
                final taskProvider = context.read<TaskProvider>();
                final settingsProvider = context.read<SettingsProvider>();
                final statsProvider = context.read<StatsProvider>();
                final sessionSyncProvider =
                    context.read<SessionSyncProvider>();

                await authProvider.logout();

                taskProvider.clear();
                await settingsProvider.resetLocal();
                statsProvider.clear();
                sessionSyncProvider.clear();
              },
              icon: const Icon(Icons.logout),
              label: const Text('Ausloggen'),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthErrorText extends StatelessWidget {
  const _AuthErrorText({required this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox.shrink();
    }

    return Text(
      error!,
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
      textAlign: TextAlign.center,
    );
  }
}