import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../core/utils/extensions.dart';

class SignOutDialog extends StatelessWidget {
  final VoidCallback signOut;

  const SignOutDialog({super.key, required this.signOut});

  @override
  Widget build(BuildContext context) {
    final s = context.s;
    return AlertDialog(
      title: Text(s.signOutConfirm),
      actions: [
        TextButton(onPressed: () => context.pop(), child: Text(s.cancel)),
        TextButton(onPressed: signOut, child: Text(s.confirm)),
      ],
    );
  }
}
