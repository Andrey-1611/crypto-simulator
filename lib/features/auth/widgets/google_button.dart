import 'package:Bitmark/core/utils/extensions.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:Bitmark/features/auth/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoogleButton extends ConsumerWidget {
  const GoogleButton({super.key});

  void signInWithGoogle(WidgetRef ref) =>
      ref.read(authNotifierProvider.notifier).signInWithGoogle();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: .symmetric(vertical: 32.sp),
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
      ),
    );
  }
}
