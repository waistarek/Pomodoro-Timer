import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/session_sync_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/task_provider.dart';
import '../services/app_session_controller.dart';
import '../services/browser_redirect_service.dart';
import '../services/browser_url_service.dart';
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

  static const _githubOauthStateKey = 'github_oauth_state';
  static const _githubOauthModeKey = 'github_oauth_mode';
  static const _githubOauthRememberKey = 'github_oauth_remember';
  static const _githubOauthRedirectUriKey = 'github_oauth_redirect_uri';

  static Future<void>? _googleInitFuture;
  static bool _googleInitialized = false;

  bool _googleSignInReady = false;
  bool _googleSignInPreparing = false;
  bool _registerMode = false;
  bool _forgotPasswordMode = false;
  bool _rememberSession = true;
  String? _resetToken;

  bool get _resetPasswordMode => _resetToken != null;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      unawaited(_handleGithubOAuthCallback());
    });
  }

  @override
  void dispose() {
    _googleSignInSubscription?.cancel();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  String _createOauthState() {
    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));

    return base64Url.encode(bytes).replaceAll('=', '');
  }

  String _githubRedirectUri() {
    final uri = Uri.base;

    return uri.replace(
      queryParameters: {
        'screen': 'account',
        'oauth_provider': 'github',
      },
    ).toString();
  }

  Future<void> _startGithubOAuth() async {
    final l10n = AppLocalizations.of(context);

    context.read<AuthProvider>().clearError();
    if (AppConfig.githubClientId.isEmpty) {
      context.read<AuthProvider>().setError(l10n.githubNotConfigured);
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final state = _createOauthState();
    final mode = _registerMode ? 'register' : 'login';
    final redirectUri = _githubRedirectUri();

    await prefs.setString(_githubOauthStateKey, state);
    await prefs.setString(_githubOauthModeKey, mode);
    await prefs.setBool(_githubOauthRememberKey, _rememberSession);
    await prefs.setString(_githubOauthRedirectUriKey, redirectUri);

    final authorizationUri = Uri.https(
      'github.com',
      '/login/oauth/authorize',
      {
        'client_id': AppConfig.githubClientId,
        'redirect_uri': redirectUri,
        'scope': 'user:email',
        'state': state,
        'prompt': 'select_account',
      },
    );

    redirectToUrl(authorizationUri.toString());
  }

  Future<void> _handleGithubOAuthCallback() async {
    final uri = Uri.base;

    if (uri.queryParameters['oauth_provider'] != 'github') {
      return;
    }

    final oauthError = uri.queryParameters['error'];

    if (oauthError != null) {
      if (!mounted) {
        return;
      }

      final l10n = AppLocalizations.of(context);
      context.read<AuthProvider>().setError(l10n.githubCancelled);
      clearLoginActionQueryParameters();
      return;
    }

    final code = uri.queryParameters['code'];
    final receivedState = uri.queryParameters['state'];

    if (code == null || receivedState == null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final expectedState = prefs.getString(_githubOauthStateKey);
    final mode = prefs.getString(_githubOauthModeKey) ?? 'login';
    final rememberSession = prefs.getBool(_githubOauthRememberKey) ?? true;
    final redirectUri =
        prefs.getString(_githubOauthRedirectUriKey) ?? _githubRedirectUri();

    await prefs.remove(_githubOauthStateKey);
    await prefs.remove(_githubOauthModeKey);
    await prefs.remove(_githubOauthRememberKey);
    await prefs.remove(_githubOauthRedirectUriKey);

    if (!mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context);

    if (expectedState == null || expectedState != receivedState) {
      context.read<AuthProvider>().setError(l10n.githubSecurityCancelled);
      clearLoginActionQueryParameters();
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final ok = await authProvider.loginWithGithubCode(
      code,
      mode: mode,
      redirectUri: redirectUri,
      rememberSession: rememberSession,
    );

    if (!mounted) {
      return;
    }

    clearLoginActionQueryParameters();

    if (ok) {
      await _loadDataAfterSuccessfulLogin(
        mode == 'register'
            ? l10n.githubAccountCreated
            : l10n.githubLoginSuccess,
      );
    }
  }

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

      final l10n = AppLocalizations.of(context);
      context.read<AuthProvider>().setError(l10n.googlePrepareFailed(e));
    }
  }

  void _prepareGoogleSignInForLoginForm() {
    if (AppConfig.googleClientId.isEmpty) {
      return;
    }

    if (_googleSignInReady || _googleSignInPreparing) {
      return;
    }

    if (_forgotPasswordMode || _resetPasswordMode) {
      return;
    }

    _googleSignInPreparing = true;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        _googleSignInPreparing = false;
        return;
      }

      unawaited(
        _initializeGoogleSignIn().whenComplete(() {
          _googleSignInPreparing = false;
        }),
      );
    });
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

      final l10n = AppLocalizations.of(context);
      context.read<AuthProvider>().setError(l10n.googleNoIdToken);
      return;
    }

    final authProvider = context.read<AuthProvider>();

    final googleMode = _registerMode ? 'register' : 'login';

    final ok = await authProvider.loginWithGoogleIdToken(
      idToken,
      mode: googleMode,
      rememberSession: _rememberSession,
    );

    if (!mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context);

    if (ok) {
      await _loadDataAfterSuccessfulLogin(
        googleMode == 'register'
            ? l10n.googleAccountCreated
            : l10n.googleLoginSuccess,
      );
    }
  }

  void _handleGoogleAuthenticationError(Object error) {
    if (!mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    context.read<AuthProvider>().setError(l10n.googleLoginFailed(error));
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
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountTitle)),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Center(
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
            ),
          );
        },
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

    _prepareGoogleSignInForLoginForm();

    return _buildLoginRegisterForm(context, provider);
  }

  Widget _buildLoginRegisterForm(
    BuildContext context,
    AuthProvider provider,
  ) {
    _prepareGoogleSignInForLoginForm();

    final l10n = AppLocalizations.of(context);
    final title = _registerMode ? l10n.createAccountTitle : l10n.loginTitle;
    final emailPasswordTitle = _registerMode
        ? l10n.emailPasswordCreateTitle
        : l10n.emailPasswordLoginTitle;

    final submitLabel =
        _registerMode ? l10n.createAccountButton : l10n.loginButton;

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
          controller: _emailController,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
          ),
          keyboardType: TextInputType.emailAddress,
          validator: _validateEmail,
        ),
        TextFormField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: l10n.passwordLabel,
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
            title: Text(l10n.rememberSessionTitle),
            subtitle: Text(l10n.rememberSessionSubtitle),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
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
                : Text(submitLabel),
          ),
        ),
        if (!_registerMode) ...[
          const SizedBox(height: 8),
          TextButton(
            onPressed: provider.loading
                ? null
                : () {
                    provider.clearError();
                    setState(() {
                      _forgotPasswordMode = true;
                    });
                  },
            child: Text(l10n.forgotPasswordButton),
          ),
        ],
        TextButton(
          onPressed: provider.loading
              ? null
              : () {
                  context.read<AuthProvider>().clearError();

                  provider.clearError();
                  setState(() {
                    _registerMode = !_registerMode;
                    _forgotPasswordMode = false;
                    _passwordController.clear();
                    _confirmPasswordController.clear();
                  });
                },
          child: Text(
            _registerMode ? l10n.alreadyHaveAccount : l10n.createAccountTitle,
          ),
        ),
        const SizedBox(height: 8),
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
        _buildGoogleAuthSection(provider),
        const SizedBox(height: 16),
        _buildGithubAuthSection(provider),
      ],
    );
  }

  Widget _buildGithubAuthSection(AuthProvider provider) {
    final l10n = AppLocalizations.of(context);
    final description =
        _registerMode ? l10n.githubCreateButton : l10n.githubLoginButton;

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
        if (AppConfig.githubClientId.isEmpty)
          Text(l10n.githubNotConfigured)
        else
          OutlinedButton.icon(
            onPressed: provider.loading ? null : _startGithubOAuth,
            icon: const Icon(Icons.code),
            label: Text(description),
          ),
      ],
    );
  }

  Widget _buildGoogleAuthSection(AuthProvider provider) {
    final l10n = AppLocalizations.of(context);
    final description =
        _registerMode ? l10n.googleCreateButton : l10n.googleLoginButton;

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
        if (AppConfig.googleClientId.isEmpty)
          Text(l10n.googleNotConfigured)
        else if (!_googleSignInReady)
          Text(l10n.googlePreparing)
        else
          GoogleWebSignInButton(
            enabled: !provider.loading,
          ),
      ],
    );
  }

  Widget _buildForgotPasswordForm(
    BuildContext context,
    AuthProvider provider,
  ) {
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
          controller: _emailController,
          decoration: InputDecoration(
            labelText: l10n.emailLabel,
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
                : Text(l10n.sendResetLink),
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
          child: Text(l10n.backToLogin),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm(
    BuildContext context,
    AuthProvider provider,
  ) {
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
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: l10n.newPasswordLabel,
          ),
          obscureText: true,
          validator: _validatePassword,
        ),
        TextFormField(
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            labelText: l10n.repeatNewPasswordLabel,
          ),
          obscureText: true,
          validator: (value) {
            if (value != _passwordController.text) {
              return l10n.passwordsDoNotMatch;
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
                : Text(l10n.savePassword),
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
          child: Text(l10n.backToLogin),
        ),
      ],
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context);
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
          SnackBar(content: Text(l10n.registrationSuccess)),
        );

        return;
      }

      await _loadDataAfterSuccessfulLogin(l10n.loginSuccess);
    }
  }

  Future<void> _submitPasswordResetRequest(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final l10n = AppLocalizations.of(context);
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
        SnackBar(content: Text(l10n.passwordResetRequestSuccess)),
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

    final l10n = AppLocalizations.of(context);
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
        SnackBar(content: Text(l10n.passwordChangedSuccess)),
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
      return AppLocalizations.of(context).invalidEmail;
    }

    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.length < 8) {
      return AppLocalizations.of(context).passwordMinLength;
    }

    return null;
  }
}

class _LoggedInCard extends StatelessWidget {
  const _LoggedInCard({required this.provider});

  final AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
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
            _AccountInfoRow(
              icon: Icons.email_outlined,
              label: l10n.emailAddress,
              value: _maskEmail(user.email),
              tooltip: user.email,
            ),
            const SizedBox(height: 12),
            _AccountInfoRow(
              icon: user.isEmailVerified
                  ? Icons.mark_email_read_outlined
                  : Icons.mark_email_unread_outlined,
              label: l10n.emailStatus,
              value: user.isEmailVerified
                  ? l10n.emailVerified
                  : l10n.emailNotVerified,
            ),
            const SizedBox(height: 12),
            _AccountInfoRow(
              icon: Icons.calendar_today_outlined,
              label: l10n.accountCreated,
              value: _formatAccountDate(user.createdAt, l10n),
            ),
            const SizedBox(height: 12),
            _AccountInfoRow(
              icon: Icons.sync_outlined,
              label: l10n.synchronization,
              value: _syncStatusText(sessionSyncProvider, l10n),
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
                label: Text(l10n.changePassword),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () => _logout(context),
                icon: const Icon(Icons.logout),
                label: Text(l10n.logout),
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
    final l10n = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final ok = await provider.requestPasswordReset(email);

    if (!context.mounted) {
      return;
    }

    if (ok) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.passwordResetMailSent)),
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

class _AuthErrorText extends StatelessWidget {
  const _AuthErrorText({required this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox.shrink();
    }

    return Text(
      _localizedAuthError(context, error!),
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
      textAlign: TextAlign.center,
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

String _formatAccountDate(DateTime date, AppLocalizations l10n) {
  return DateFormat.yMd(l10n.localeName).format(date.toLocal());
}

String _syncStatusText(
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

String _localizedAuthError(BuildContext context, String error) {
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
