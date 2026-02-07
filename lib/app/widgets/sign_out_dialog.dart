import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class SignOutDialog extends StatelessWidget {
  final VoidCallback signOut;
  const SignOutDialog({super.key, required this.signOut});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Вы уверены, что хотите выйти из акканта?'),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Отмена'),
        ),
        TextButton(onPressed: signOut, child: const Text('Подтвердить')),
      ],
    );
  }
}
