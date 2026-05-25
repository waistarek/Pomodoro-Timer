import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../providers/settings_provider.dart';
import '../providers/stats_provider.dart';
import '../providers/task_provider.dart';
import '../services/session_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _registerMode = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              if (provider.user != null) {
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
                            final settingsProvider =
                                context.read<SettingsProvider>();
                            final statsProvider = context.read<StatsProvider>();

                            await authProvider.logout();

                            if (!mounted) {
                              return;
                            }

                            taskProvider.clear();
                            await settingsProvider.resetLocal();
                            statsProvider.clear();
                          },
                          icon: const Icon(Icons.logout),
                          label: const Text('Ausloggen'),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
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
                          validator: (value) =>
                              value == null || !value.contains('@')
                                  ? 'Bitte gültige E-Mail eingeben'
                                  : null,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Passwort',
                          ),
                          obscureText: true,
                          validator: (value) =>
                              value == null || value.length < 8
                                  ? 'Mindestens 8 Zeichen'
                                  : null,
                        ),
                        const SizedBox(height: 16),
                        if (provider.error != null)
                          Text(
                            provider.error!,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            onPressed: provider.loading
                                ? null
                                : () => _submit(context),
                            child: provider.loading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(
                                    _registerMode
                                        ? 'Konto erstellen'
                                        : 'Einloggen',
                                  ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() => _registerMode = !_registerMode);
                          },
                          child: Text(
                            _registerMode
                                ? 'Ich habe bereits ein Konto'
                                : 'Neues Konto erstellen',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final sessionService = context.read<SessionService>();
    final authProvider = context.read<AuthProvider>();
    final taskProvider = context.read<TaskProvider>();
    final settingsProvider = context.read<SettingsProvider>();
    final messenger = ScaffoldMessenger.of(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final ok = _registerMode
        ? await authProvider.register(email, password)
        : await authProvider.login(email, password);

    if (!mounted) {
      return;
    }

    if (ok) {
      await settingsProvider.loadRemoteSettings();
      await sessionService.syncPendingSessions();
      await taskProvider.loadRemoteTasks();

      if (!mounted) {
        return;
      }

      messenger.showSnackBar(
        const SnackBar(content: Text('Erfolgreich angemeldet.')),
      );
    }
  }
}
