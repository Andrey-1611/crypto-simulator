import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const .symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title, style: theme.textTheme.bodyMedium),
          Text(value, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
