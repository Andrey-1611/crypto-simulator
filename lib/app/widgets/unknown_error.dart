import 'package:flutter/material.dart';

class UnknownError extends StatelessWidget {
  final VoidCallback? onPressed;

  const UnknownError({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Неизвестная ошибка', style: theme.textTheme.displayLarge),
          onPressed != null
              ? TextButton(
                  onPressed: onPressed,
                  child: const Text('Попробовать еще раз'),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
