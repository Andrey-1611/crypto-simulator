import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

class UnknownError extends StatelessWidget {
  final VoidCallback? onPressed;

  const UnknownError({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = S.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(s.unknown_error, style: theme.textTheme.displayLarge),
          onPressed != null
              ? TextButton(onPressed: onPressed, child: Text(s.try_again))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
