import 'package:Bitmark/app/widgets/size_box.dart';
import 'package:flutter/material.dart';

class InfoBloc extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const InfoBloc({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(title, style: theme.textTheme.bodyLarge),
            const SizeBox(height: 0.02),
            ...children,
          ],
        ),
      ),
    );
  }
}
