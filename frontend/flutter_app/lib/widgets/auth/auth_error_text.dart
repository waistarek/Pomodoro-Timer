import 'package:flutter/material.dart';

import 'auth_helpers.dart';

class AuthErrorText extends StatelessWidget {
  const AuthErrorText({
    super.key,
    required this.error,
  });

  final String? error;

  @override
  Widget build(BuildContext context) {
    if (error == null) {
      return const SizedBox.shrink();
    }

    return Text(
      localizedAuthError(context, error!),
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
      ),
      textAlign: TextAlign.center,
    );
  }
}
