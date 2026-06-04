import 'dart:async';
import '../services/app_session_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/session_sync_provider.dart';
import '../providers/settings_provider.dart';

import '../providers/task_provider.dart';

import '../services/browser_url_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../config/app_config.dart';
import '../widgets/google_sign_in_button.dart';

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
  StreamSubscription<GoogleSignInAuthenticationEvent>?
      _googleSignInSubscription;

  static Future<void>? _googleInitFuture;
  static bool _googleInitialized = false;

  bool _googleSignInReady = false;
  bool _registerMode = false;
  bool _forgotPasswordMode = false;
  bool _rememberSession = true;
  String? _resetToken;

  bool get _resetPasswordMode => _resetToken != null;

  Future<void> _ensureGoogleSignInInitialized() async {
    if (AppConfig.googleClientId.isEmpty) {
      return;
    }

    if (_googleInitialized) {
      return;
    }

    try {
      _googleInitFuture ??= GoogleSignIn.instance
          .initialize(
        clientId: AppConfig.googleClientId,
        serverClientId: AppConfig.googleClientId,
      )
          .then((_) {
        _googleInitialized = true;
      });

      await _googleInitFuture;
    } catch (_) {
      _googleInitFuture = null;
      _googleInitialized = false;
      rethrow;
    }
  }

  Future<void> _initializeGoogleSignIn() async {
    if (AppConfig.googleClientId.isEmpty) {
      return;
    }

    try {
      await _ensureGoogleSignInInitialized();

      if (!mounted) {
        return;
      }

      setState(() {
        _googleSignInReady = true;
      });

      _googleSignInSubscription ??=
          GoogleSignIn.instance.authenticationEvents.listen(
        _handleGoogleAuthenticationEvent,
        onError: _handleGoogleAuthenticationError,
      );
    } catch (e) {
      if (!mounted) {
        return;
      }

      context.read<AuthProvider>().setError(
            'Google Login konnte nicht vorbereitet werden: $e',
          );
    }
  }

  Future<void> _handleGoogleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? account = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    if (account == null) {
      return;
    }

    final idToken = account.authentication.idToken;

    if (idToken == null || idToken.isEmpty) {
      if (!mounted) {
        return;
      }

      context.read<AuthProvider>().setError(
            'Google hat keinen gültigen ID-Token zurückgegeben.',
          );
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final ok = await authProvider.loginWithGoogleIdToken(
      idToken,
      rememberSession: _rememberSession,
    );

    if (!mounted) {
      return;
    }

    if (ok) {
      await _loadDataAfterSuccessfulLogin(
        'Erfolgreich mit Google angemeldet.',
      );
    }
  }

  void _handleGoogleAuthenticationError(Object error) {
    if (!mounted) {
      return;
    }

    context.read<AuthProvider>().setError(
          'Google Login fehlgeschlagen: $error',
        );
  }

  Future<void> _loadDataAfterSuccessfulLogin(String message) async {
    final taskProvider = context.read<TaskProvider>();
    final settingsProvider = context.read<SettingsProvider>();
    final sessionSyncProvider = context.read<SessionSyncProvider>();
    final messenger = ScaffoldMessenger.of(context);

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
      SnackBar(content: Text(message)),
    );
  }

  @override
  void initState() {
    super.initState();

    final uri = Uri.base;
    _resetToken =
        uri.queryParameters['reset_token'] ?? uri.queryParameters['set_token'];

    final email = uri.queryParameters['email'];
    if (email != null && email.isNotEmpty) {
      _emailController.text = email;
    }
    unawaited(_initializeGoogleSignIn());
  }

  @override
  void dispose() {
    _googleSignInSubscription?.cancel();
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
        if (!_registerMode)
          CheckboxListTile(
            value: _rememberSession,
            onChanged: provider.loading
                ? null
                : (value) {
                    setState(() {
                      _rememberSession = value ?? true;
                    });
                  },
            title: const Text('Auf diesem Gerät angemeldet bleiben'),
            subtitle: const Text(
              'Wenn deaktiviert, bleibt die Anmeldung nur für die aktuelle App-Sitzung aktiv.',
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
        const SizedBox(height: 16),
        if (!_registerMode) ...[
          const SizedBox(height: 12),
          const Row(
            children: [
              Expanded(child: Divider()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('oder'),
              ),
              Expanded(child: Divider()),
            ],
          ),
          const SizedBox(height: 12),
          if (AppConfig.googleClientId.isEmpty)
            const Text('Google Login ist nicht konfiguriert.')
          else if (!_googleSignInReady)
            const Text('Google Login wird vorbereitet ...')
          else
            GoogleWebSignInButton(
              enabled: !provider.loading,
            ),
        ],
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
                  clearLoginActionQueryParameters();

                  setState(() {
                    _forgotPasswordMode = false;
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
            onPressed:
                provider.loading ? null : () => _submitResetPassword(context),
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
                  clearLoginActionQueryParameters();

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
    final messenger = ScaffoldMessenger.of(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final wasRegisterMode = _registerMode;
    final ok = _registerMode
        ? await authProvider.register(email, password)
        : await authProvider.login(
            email,
            password,
            rememberSession: _rememberSession,
          );

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

      await _loadDataAfterSuccessfulLogin('Erfolgreich angemeldet.');
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
      clearLoginActionQueryParameters();
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
    final user = provider.user!;
    final sessionSyncProvider = context.watch<SessionSyncProvider>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.verified_user, size: 64),
            const SizedBox(height: 16),
            Text(
              'Benutzerkonto',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Du bist aktuell angemeldet.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            _AccountInfoRow(
              icon: Icons.email_outlined,
              label: 'E-Mail-Adresse',
              value: _maskEmail(user.email),
              tooltip: user.email,
            ),
            const SizedBox(height: 12),
            _AccountInfoRow(
              icon: user.isEmailVerified
                  ? Icons.mark_email_read_outlined
                  : Icons.mark_email_unread_outlined,
              label: 'E-Mail-Status',
              value:
                  user.isEmailVerified ? 'Bestätigt' : 'Noch nicht bestätigt',
            ),
            const SizedBox(height: 12),
            _AccountInfoRow(
              icon: Icons.calendar_today_outlined,
              label: 'Konto erstellt',
              value: _formatAccountDate(user.createdAt),
            ),
            const SizedBox(height: 12),
            _AccountInfoRow(
              icon: Icons.sync_outlined,
              label: 'Synchronisierung',
              value: _syncStatusText(sessionSyncProvider),
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
                      'Die App kann deine Sitzung automatisch wiederherstellen, '
                      'wenn ein gültiger Anmeldetoken lokal gespeichert ist. '
                      'Auf fremden Geräten solltest du dich immer ausloggen.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _AuthErrorText(error: provider.error),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: provider.loading
                    ? null
                    : () => _sendPasswordResetMail(
                          context,
                          provider,
                          user.email,
                        ),
                icon: const Icon(Icons.lock_reset),
                label: const Text('Passwort ändern'),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: const Text('Ausloggen'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendPasswordResetMail(
    BuildContext context,
    AuthProvider provider,
    String email,
  ) async {
    final messenger = ScaffoldMessenger.of(context);

    final ok = await provider.requestPasswordReset(email);

    if (!context.mounted) {
      return;
    }

    if (ok) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Wenn das Konto existiert, wurde ein Link zum Zurücksetzen gesendet.',
          ),
        ),
      );
    }
  }

  Future<void> _logout(BuildContext context) async {
    final sessionController = context.read<AppSessionController>();

    await sessionController.logout();
  }
}

class _AccountInfoRow extends StatelessWidget {
  const _AccountInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.tooltip,
  });

  final IconData icon;
  final String label;
  final String value;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final valueWidget = Text(
      value,
      style: Theme.of(context).textTheme.bodyMedium,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              tooltip == null
                  ? valueWidget
                  : Tooltip(
                      message: tooltip!,
                      child: valueWidget,
                    ),
            ],
          ),
        ),
      ],
    );
  }
}

String _maskEmail(String email) {
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

String _formatAccountDate(DateTime date) {
  final localDate = date.toLocal();

  final day = localDate.day.toString().padLeft(2, '0');
  final month = localDate.month.toString().padLeft(2, '0');
  final year = localDate.year.toString();

  return '$day.$month.$year';
}

String _syncStatusText(SessionSyncProvider provider) {
  if (provider.syncing) {
    return 'Synchronisierung läuft';
  }

  if (provider.pendingCount == 1) {
    return '1 Sitzung wartet';
  }

  if (provider.pendingCount > 1) {
    return '${provider.pendingCount} Sitzungen warten';
  }

  if (provider.error != null) {
    return 'Fehler bei der Synchronisierung';
  }

  return 'Alles synchronisiert';
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
