import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';
import '../providers/session_sync_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/task_provider.dart';
import '../router/app_routes.dart';
import '../services/app_session_controller.dart';
import '../services/browser_redirect_service.dart';
import '../widgets/auth/logged_in_account_card.dart';
import '../widgets/auth/login_register_form.dart';
import '../widgets/auth/oauth_auth_section.dart';
import '../widgets/auth/password_reset_request_form.dart';
import '../widgets/auth/reset_password_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.resetToken,
    this.initialEmail,
    this.emailVerificationStatus,
    this.oauthProvider,
    this.githubCode,
    this.githubState,
    this.githubError,
    this.githubErrorDescription,
    this.redirectPath,
  });

  final String? resetToken;
  final String? initialEmail;
  final String? emailVerificationStatus;
  final String? oauthProvider;
  final String? githubCode;
  final String? githubState;
  final String? githubError;
  final String? githubErrorDescription;
  final String? redirectPath;

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
  static const _githubOauthRedirectPathKey = 'github_oauth_redirect_path';
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

    _applyRouteParameters();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }

      _showEmailVerificationMessage();
      unawaited(_handleGithubOAuthCallback());
    });
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.resetToken != widget.resetToken ||
        oldWidget.initialEmail != widget.initialEmail) {
      setState(_applyRouteParameters);
    }

    if (oldWidget.emailVerificationStatus != widget.emailVerificationStatus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showEmailVerificationMessage();
        }
      });
    }

    if (oldWidget.oauthProvider != widget.oauthProvider ||
        oldWidget.githubCode != widget.githubCode ||
        oldWidget.githubState != widget.githubState ||
        oldWidget.githubError != widget.githubError) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          unawaited(_handleGithubOAuthCallback());
        }
      });
    }
  }

  void _applyRouteParameters() {
    _resetToken = widget.resetToken;

    final email = widget.initialEmail;
    if (email != null && email.isNotEmpty) {
      _emailController.text = email;
    }
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

    return uri
        .replace(
          path: AppRoutes.githubCallback,
          queryParameters: const {},
          fragment: '',
        )
        .toString();
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
    final safeRedirectPath =
        AppRoutes.safeInternalRedirect(widget.redirectPath);
    if (safeRedirectPath == null) {
      await prefs.remove(_githubOauthRedirectPathKey);
    } else {
      await prefs.setString(_githubOauthRedirectPathKey, safeRedirectPath);
    }

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
    if (widget.oauthProvider != 'github') {
      return;
    }

    final oauthError = widget.githubError;

    if (oauthError != null) {
      if (!mounted) {
        return;
      }

      final l10n = AppLocalizations.of(context);
      context.read<AuthProvider>().setError(l10n.githubCancelled);
      _goToAccountWithoutActionParameters();
      return;
    }

    final code = widget.githubCode;
    final receivedState = widget.githubState;

    if (code == null || receivedState == null) {
      return;
    }

    final prefs = await SharedPreferences.getInstance();

    final expectedState = prefs.getString(_githubOauthStateKey);
    final mode = prefs.getString(_githubOauthModeKey) ?? 'login';
    final rememberSession = prefs.getBool(_githubOauthRememberKey) ?? true;
    final redirectUri =
        prefs.getString(_githubOauthRedirectUriKey) ?? _githubRedirectUri();
    final redirectPath = prefs.getString(_githubOauthRedirectPathKey);

    await prefs.remove(_githubOauthStateKey);
    await prefs.remove(_githubOauthModeKey);
    await prefs.remove(_githubOauthRememberKey);
    await prefs.remove(_githubOauthRedirectUriKey);
    await prefs.remove(_githubOauthRedirectPathKey);

    if (!mounted) {
      return;
    }

    final l10n = AppLocalizations.of(context);

    if (expectedState == null || expectedState != receivedState) {
      context.read<AuthProvider>().setError(l10n.githubSecurityCancelled);
      _goToAccountWithoutActionParameters();
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

    if (ok) {
      await _finishSuccessfulLogin(
        mode == 'register'
            ? l10n.githubAccountCreated
            : l10n.githubLoginSuccess,
        redirectPath: redirectPath,
      );
      return;
    }

    _goToAccountWithoutActionParameters();
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
      context
          .read<AuthProvider>()
          .setError(l10n.googlePrepareFailed(e.toString()));
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
      await _finishSuccessfulLogin(
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
    context
        .read<AuthProvider>()
        .setError(l10n.googleLoginFailed(error.toString()));
  }

  Future<void> _loadDataAfterSuccessfulLogin(String message) async {
    final taskProvider = context.read<TaskProvider>();
    final settingsProvider = context.read<SettingsProvider>();
    final sessionSyncProvider = context.read<SessionSyncProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final preferredLocale = settingsProvider.settings.appLocale;
    final shouldKeepPreferredLocale =
        AppRoutes.isSupportedLandingLocale(preferredLocale);

    await settingsProvider.loadRemoteSettings();

    if (shouldKeepPreferredLocale &&
        settingsProvider.settings.appLocale != preferredLocale) {
      await settingsProvider.save(
        settingsProvider.settings.copyWith(appLocale: preferredLocale),
      );
    }

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

  Future<void> _finishSuccessfulLogin(
    String message, {
    String? redirectPath,
  }) async {
    await _loadDataAfterSuccessfulLogin(message);

    if (!mounted) {
      return;
    }

    context.go(
      AppRoutes.safeInternalRedirect(redirectPath) ??
          AppRoutes.safeInternalRedirect(widget.redirectPath) ??
          AppRoutes.timer,
    );
  }

  void _showEmailVerificationMessage() {
    final emailVerificationStatus = widget.emailVerificationStatus;

    if (emailVerificationStatus == null) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final message = switch (emailVerificationStatus) {
      'success' => l10n.emailVerifiedSuccess,
      'expired' => l10n.emailVerifiedExpired,
      'invalid' => l10n.emailVerifiedInvalid,
      _ => null,
    };

    if (message != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }

    _goToAccountWithoutActionParameters();
  }

  void _goToAccountWithoutActionParameters() {
    if (!mounted) {
      return;
    }

    context.go(AppRoutes.account);
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
                        final sessionSyncProvider =
                            context.watch<SessionSyncProvider>();

                        return LoggedInAccountCard(
                          provider: provider,
                          sessionSyncProvider: sessionSyncProvider,
                          onChangePassword: () => unawaited(
                            _sendPasswordResetMail(provider.user!.email),
                          ),
                          onLogout: () => unawaited(_logout()),
                        );
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
      return ResetPasswordForm(
        passwordController: _passwordController,
        confirmPasswordController: _confirmPasswordController,
        loading: provider.loading,
        error: provider.error,
        onSubmit: () => unawaited(_submitResetPassword(context)),
        onBackToLogin: () => _backToLogin(provider),
        validatePassword: _validatePassword,
      );
    }

    if (_forgotPasswordMode) {
      return PasswordResetRequestForm(
        emailController: _emailController,
        loading: provider.loading,
        error: provider.error,
        onSubmit: () => unawaited(_submitPasswordResetRequest(context)),
        onBackToLogin: () => _backToLogin(provider),
        validateEmail: _validateEmail,
      );
    }

    _prepareGoogleSignInForLoginForm();

    return LoginRegisterForm(
      emailController: _emailController,
      passwordController: _passwordController,
      registerMode: _registerMode,
      rememberSession: _rememberSession,
      loading: provider.loading,
      error: provider.error,
      onSubmit: () => unawaited(_submit(context)),
      onForgotPassword: () => _showForgotPassword(provider),
      onToggleRegisterMode: () => _toggleRegisterMode(provider),
      onRememberSessionChanged: (value) {
        setState(() {
          _rememberSession = value;
        });
      },
      validateEmail: _validateEmail,
      validatePassword: _validatePassword,
      oauthSection: OauthAuthSection(
        registerMode: _registerMode,
        loading: provider.loading,
        googleConfigured: AppConfig.googleClientId.isNotEmpty,
        googleReady: _googleSignInReady,
        githubConfigured: AppConfig.githubClientId.isNotEmpty,
        onStartGithubOAuth: () => unawaited(_startGithubOAuth()),
      ),
    );
  }

  void _showForgotPassword(AuthProvider provider) {
    provider.clearError();

    setState(() {
      _forgotPasswordMode = true;
    });
  }

  void _toggleRegisterMode(AuthProvider provider) {
    provider.clearError();

    setState(() {
      _registerMode = !_registerMode;
      _forgotPasswordMode = false;
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
  }

  void _backToLogin(AuthProvider provider) {
    provider.clearError();
    _goToAccountWithoutActionParameters();

    setState(() {
      _forgotPasswordMode = false;
      _resetToken = null;
      _passwordController.clear();
      _confirmPasswordController.clear();
    });
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

      await _finishSuccessfulLogin(l10n.loginSuccess);
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
      _goToAccountWithoutActionParameters();
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

  Future<void> _sendPasswordResetMail(String email) async {
    final l10n = AppLocalizations.of(context);
    final provider = context.read<AuthProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final ok = await provider.requestPasswordReset(email);

    if (!mounted) {
      return;
    }

    if (ok) {
      messenger.showSnackBar(
        SnackBar(content: Text(l10n.passwordResetMailSent)),
      );
    }
  }

  Future<void> _logout() async {
    final sessionController = context.read<AppSessionController>();

    await sessionController.logout();
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
