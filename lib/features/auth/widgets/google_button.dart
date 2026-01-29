import 'package:auth_buttons/auth_buttons.dart';
import 'package:crypto_simulator/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({super.key});

  void signInWithGoogle(WidgetRef ref) =>
      ref.read(authNotifierProvider.notifier).signInWithGoogle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .symmetric(vertical: 32),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: .center,
            children: [
              Expanded(child: Divider()),
              Padding(padding: .symmetric(horizontal: 8), child: Text('или')),
              Expanded(child: Divider()),
            ],
          ),
          GoogleAuthButton(
            themeMode: theme.brightness == Brightness.dark
                ? ThemeMode.dark
                : ThemeMode.light,
            text: 'Войти с Google',
            onPressed: () => signInWithGoogle(ref),
          ),
        ],
      ),
    );
  }
}
